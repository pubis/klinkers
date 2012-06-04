class Transaction < ActiveRecord::Base
  validates :operation_date, :presence => true

  attr_accessor :category_id, :account, :memo, :amount

  has_many :transaction_items
  accepts_nested_attributes_for :transaction_items
  validates_associated :transaction_items
  validate :validate_minimum_of_two_items,
           :validate_transaction_balances

  has_many :accounts,
    :through => :transaction_items
  
  has_many :categories,
    :through => :transaction_items,
    :group => "transaction_items.category_id"
    
  def validate_minimum_of_two_items
    lngth = transaction_items.length
    if lngth < 2
      errors.add(:base, "There must be atleast two (2) items, got #{lngth}")
    end
  end
  
  def validate_transaction_balances
    sum = "0.0".to_d
    transaction_items.map { |item| sum += item.amount if item.amount }
    if sum != "0.0".to_d
      errors.add(:base, "Transaction doesn't balance, diff: #{sum}")
    end
  end

  def account_items(account)
    transaction_items - transaction_items.map { |i| i if i.account_id != account.id }
  end

  def remote_items(account)
    transaction_items - account_items(account)
  end
  
  def remote_accounts(account)
    accounts.uniq - [account]
  end
  
  def build_items(user, account, opts = {})
    transaction_items.new(
      category_id: opts[:category_id], 
      account_id: find_or_create_account(user, opts[:account]).id, 
      amount: opts[:amount], 
      memo: opts[:memo]
    )
    transaction_items.new(
      category_id: opts[:category_id], 
      account_id: account.id, 
      amount: opts[:amount].to_d * -1, 
      memo: opts[:memo]
    )
  end

  def find_or_create_account(u, a)
    # Find the id of the supplied account or create new if none exists
    account_name = a.blank? ? "Anonymous Payee" : a
    account = u.payees.where(name: account_name).first_or_create!(opening_balance: 0)
  end

  # Allow childred to use parents route
  def self.inherited(child)
    child.instance_eval do
      def model_name
        Transaction.model_name
      end
    end
    super
  end

  # Helper to create select options for each child class currently loaded
  def self.select_options
    descendants.map{ |c| c.to_s }.sort
  end
end
