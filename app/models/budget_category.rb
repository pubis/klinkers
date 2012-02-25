class BudgetCategory < ActiveRecord::Base
  belongs_to :budget
  belongs_to :category
  
  validates :amount, :presence => true, :numericality => true
  
  def budgeted_for_period(period)
    self.amount
  end
  
  def actual_for_period(period)
    account_ids = budget.account_ids
    TransactionItem.joins(:transaction).where(
      'account_id IN (?) AND category_id = ? AND operation_date >= ? AND operation_date <= ?', 
      account_ids, 
      category.id,
      period.start_date,
      period.end_date
    ).sum(:amount).abs
  end
end
