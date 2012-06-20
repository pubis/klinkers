class BudgetCategory < ActiveRecord::Base
  belongs_to :budget
  belongs_to :category
  
  validates :amount, :presence => true, :numericality => true
  
  def budgeted_for_period(period)
    self.amount
  end
  
  def actual_for_period(period)
    TransactionItem
      .joins(:transaction)
      .where(account_id: budget.account_ids)
      .where(category_id: category.id)
      .merge(Transaction.occured_during(period.start_date..period.end_date))
      .sum(:amount)
      .abs
  end
  
  def category_name
    @category_name ||= self.category.display_name
  end
end
