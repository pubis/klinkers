class BudgetPeriod < ActiveRecord::Base
  belongs_to :budget
  
  def active?
    (self.start_date <= Date.today  && Date.today <= self.end_date)
  end
end
