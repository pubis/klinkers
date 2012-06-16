class Portfolio < Account
  has_many :portfolio_investments
  has_many :investments, through: :portfolio_investments

  def self.model_name
    ActiveModel::Name.new(Portfolio)
  end
end