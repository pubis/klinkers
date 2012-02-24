class Budget < ActiveRecord::Base
  belongs_to :user

  has_many :budget_accounts, :dependent => :destroy
  has_many :accounts, :through => :budget_accounts

  has_many :budget_categories, :dependent => :destroy, :include => :category
  
  has_many :budget_periods, :dependent => :destroy
  
  validates :name, :presence => true
  validates :interval, :presence => true
  validates :account_ids, :presence => true
end
