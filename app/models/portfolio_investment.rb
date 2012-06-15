class PortfolioInvestment < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :investment
end
