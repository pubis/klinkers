class User < ActiveRecord::Base
  has_secure_password
  
  store :settings, accessors: [:default_account, :default_payee, :language]
  
  validates :username, :presence => true
  validates :email, :presence => true
  
  belongs_to :currency
  
  has_many :accounts, :dependent => :destroy
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

  private
  def build_system_accounts
    self.accounts.build(name: 'Opening balances', system: true, payee: true)
    self.accounts.build(name: 'Taxes', system: true, payee: true)
    self.save
  end
end
