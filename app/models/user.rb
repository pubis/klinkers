class User < ActiveRecord::Base
  has_secure_password
  
  store :settings, accessors: [:default_account, :default_payee, :language, :active_budget]
  
  attr_accessible :username, :email, :first_name, :last_name, :language, :currency_id, :password, :password_confirmation
  
  email_regex = /@/ #Super simple
  validates :username, presence: true, uniqueness: true, exclusion: { in: %w(admin root superuser moderator demo) }
  validates :email, presence: true, uniqueness: true, format: { with: email_regex }
  validates :password, on: :create, confirmation: true, presence: true
  
  belongs_to :currency
  
  has_many :portfolios
  has_many :payees
  has_many :accounts
  has_many :budgets
  has_many :categories
  
  after_create :build_system_accounts
  
  def net_worth
    nw = 0.0
    self.accounts.users.each { |a| nw += a.balance }
    nw
  end
  
  def locale
    self.language.blank? ? "en" : self.language
  end
  
  def budget
    if self.active_budget.present?
      budgets.find(self.active_budget)
    else
      nil
    end
  end

  private
  def build_system_accounts
    self.payees.build(name: 'Opening balances', system: true)
    self.payees.build(name: 'Taxes', system: true)
    self.save
  end
end
