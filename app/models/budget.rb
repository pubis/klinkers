class Budget < ActiveRecord::Base
  belongs_to :user

  has_many :budget_accounts, :dependent => :destroy
  has_many :accounts, :through => :budget_accounts

  has_many :budget_categories, :dependent => :destroy, :include => :category
  
  has_many :budget_periods, :dependent => :destroy

  attr_accessor :starting_at
  columns_hash["starting_at"] = ActiveRecord::ConnectionAdapters::Column.new("starting_at", nil, "date")
  
  after_create :create_periods
  
  validates :name, :presence => true
  validates :interval, :presence => true
  validates :account_ids, :presence => true
  
  private
  def create_periods
    period_start = self.starting_at
    i = 1
    while period_start < Date.today
      next_start = period_start + self.interval.to_i.months
      period_end = next_start - 1.day
      period = self.budget_periods.create(start_date: period_start, end_date: period_end, position: i)
      period_start = next_start
      i += 1
    end
  end
end
