class Category < ActiveRecord::Base
  belongs_to :parent, :class_name => "Category"
  has_many :children, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  
  belongs_to :user

  has_many :transaction_items

  validates :name, :presence => true
  validates :locale, :presence => true
  
  validate :child_match_parent

  scope :roots, where('parent_id IS NULL')
  scope :expenses, where(:expense => true)
  scope :incomes, where(:expense => false)

  def display_name
    if self.parent
      "#{self.parent.display_name} : #{self.name}"
    else
      "#{self.name}"
    end
  end
  
  def child_match_parent
    if parent
      if parent.expense != expense
        errors.add(:base, "Child income/expense must match parent")
      end
      if parent.locale != locale
        errors.add(:base, "Child locale must match parent")
      end
      if parent.user != user
        errors.add(:base, "Child user must match parent")
      end
    end
  end

  def spending_for_period(accounts, start_date, end_date)
    item = TransactionItem
      .select("SUM(transaction_items.amount) AS amount")
      .joins(:transaction)
      .where(account_id: accounts.map { |a| a.id })
      .where(category_id: self.id)
      .merge(Transaction.occured_during(start_date..end_date))
      .group(:category_id)
      .first

    if item && item.amount
      item.amount.abs
    else
      0.0
    end
  end
end
