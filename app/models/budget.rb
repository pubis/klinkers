class Budget < ActiveRecord::Base
  belongs_to :user

  has_many :budget_accounts, :dependent => :destroy
  has_many :accounts, :through => :budget_accounts

  has_many :budget_categories, :dependent => :destroy, :include => :category
  
  has_many :budget_periods, :dependent => :destroy, :order => "start_date DESC"

  attr_accessor :starting_at
  columns_hash["starting_at"] = ActiveRecord::ConnectionAdapters::Column.new("starting_at", nil, "date")
  
  after_create :create_periods
  
  validates :name, :presence => true
  validates :interval, :presence => true
  validates :account_ids, :presence => true
  
  def income_categories
    self.budget_categories.joins(:category).where(:categories => {:expense => false})
  end

  def expense_categories
    self.budget_categories.joins(:category).where(:categories => {:expense => true})
  end
  
  def budgeted_income_for_period(period)
    amount = 0.0
    income_categories.each { |c| amount += c.budgeted_for_period(period) }
    amount
  end

  def actual_income_for_period(period)
    amount = 0.0
    income_categories.each { |c| amount += c.actual_for_period(period) }
    amount
  end

  def budgeted_expense_for_period(period)
    amount = 0.0
    expense_categories.each { |c| amount += c.budgeted_for_period(period) }
    amount
  end

  def actual_expense_for_period(period)
    amount = 0.0
    expense_categories.each { |c| amount += c.actual_for_period(period) }
    amount
  end

  def active_period
    period = budget_periods.first
    if period.end_date < Date.today
      # Period has expired, so create next
      period = budget_periods.create(
        start_date: period.start_date + interval.to_i.months, 
        end_date: period.end_date + interval.to_i.months
      )
    end
    period
  end
  
  private
  def create_periods
    period_start = self.starting_at
    while period_start < Date.today
      next_start = period_start + self.interval.to_i.months
      period_end = next_start - 1.day
      period = self.budget_periods.create(start_date: period_start, end_date: period_end)
      period_start = next_start
    end
  end
end
