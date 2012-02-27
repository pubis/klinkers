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
  scope :payees, where(payee: true)
  scope :no_payees, where(payee: false)
  scope :systems, where(system: true)
  scope :no_systems, where(system: false)
  scope :users, where(payee: false, system: false)

  def balance
    @balance_cache ||= transaction_items.sum(:amount)
  end
  
  def available
    if credit_limit.present? and balance < 0
      return balance + credit_limit
    end
    balance
  end
  
#  def balance_as_of(date)
#    transaction_items.where("transactions.operation_date < ?", date).sum(:amount)
#  private
  
  def create_opening_transaction
    # Skip for system accounts and payees
    unless self.system || self.payee
      # Defaults
      self.opening_balance ||= "0.0"
      self.opening_date ||= Time.zone.today

      # Find system account
      opening_balance_account = self.user.accounts.systems.where(:name => "Opening balances").first

      # Deposit or withdrawal?
      if self.opening_balance.to_d >= 0
        transaction = Transaction.new(:event => 'Deposit', :operation_date => self.opening_date)
      else
        transaction = Transaction.new(:event => 'Withdrawal', :operation_date => self.opening_date)
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
end