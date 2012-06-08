class Account < ActiveRecord::Base
  #
  # Attributes
  store :settings, accessors: [:interest_rate, :credit_limit]

  attr_accessor :opening_balance, :opening_date
  columns_hash["opening_date"] = ActiveRecord::ConnectionAdapters::Column.new("opening_date", nil, "date")

  #
  # Validations
  validates :name, :presence => true
  validates :opening_balance, :numericality => true, :allow_nil => true

  #
  # Callbacks
  before_save :set_user_currency
  after_create :create_opening_transaction

  #
  # Relations
  belongs_to :user
  belongs_to :currency
  
  has_many :transaction_items,
    :order => "transactions.operation_date DESC, transactions.id DESC"

  has_many :transactions, 
    :through => :transaction_items,
    :group => "transactions.id",
    :order => "transactions.operation_date DESC, transactions.id DESC",
    :include => [:transaction_items, :accounts, :categories]

  #
  # Scopes
  scope :favorites, where(favorite: true)
  scope :no_favorites, where(favorite: false)
  scope :systems, where(system: true)
  scope :no_systems, where(system: false)
  scope :users, where("type != 'Payee'", system: false)

  def balance
    @balance_cache ||= transaction_items.sum(:amount)
  end
  
  def available
    balance
  end
  
  def balance_as_of(date)
    transaction_items.joins(:transaction).where("transactions.operation_date <= ?", date).sum(:amount)
  end

  def build_transaction(opts = {})
    class_name = opts[:type].constantize
    transaction = class_name.create(opts.except(:type))
    transaction.build_items(user, self, opts)
    transaction
  end

  private
  
  def create_opening_transaction
    # Skip for system accounts and payees
    unless self.system || self.type == 'Payee'
      # Defaults
      self.opening_balance ||= "0.0"
      self.opening_date ||= Time.zone.today

      # Find system account
      opening_balance_account = self.user.payees.systems.where(:name => "Opening balances").first

      # Deposit or withdrawal?
      if self.opening_balance.to_d >= 0
        transaction = Deposit.new(:operation_date => self.opening_date)
      else
        transaction = Withdrawal.new(:operation_date => self.opening_date)
      end

      # Build items and save
      transaction.transaction_items.build([
        {:memo => 'Opening balance', :amount => self.opening_balance.to_d, :account => self},
        {:memo => 'Opening balance', :amount => -1 * self.opening_balance.to_d, :account => opening_balance_account }
      ])
      transaction.save
    end
  end

  def set_user_currency
    if self.currency.nil?
      self.currency = self.user.currency
    end
  end

  # Some STI hacks and tricks

  def self.inherited(child)
    # Allow childred to use parents route
    child.instance_eval do
      def model_name
        Account.model_name
      end
    end

    # Hack to make children handle virtual date-attribute correctly
    child.class_eval do
      columns_hash["opening_date"] = ActiveRecord::ConnectionAdapters::Column.new("opening_date", nil, "date")
    end

    super
  end

  # Helper to create select options for each child class currently loaded
  def self.select_options
    ["Account"] + descendants.map{ |c| c.to_s }.sort
  end
end