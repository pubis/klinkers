class BudgetAccount < ActiveRecord::Base
  belongs_to :budget
  belongs_to :account
end
