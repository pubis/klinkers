class Transaction < ActiveRecord::Base
  validates :event, :presence => true
  validates :operation_date, :presence => true

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
end
