class BudgetCategory < ActiveRecord::Base
  belongs_to :budget
  belongs_to :category
  
  validates :amount, :presence => true, :numericality => true
  
  def budgeted
    self.amount
  end
  
  def actual
    account_ids = budget.account_ids
    TransactionItem.where('account_id IN (?) AND category_id = ?', account_ids, category.id).sum(:amount).abs
  end
end
