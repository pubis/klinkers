class Portfolio < Account
  has_many :portfolio_investments
  has_many :investments, through: :portfolio_investments

  def self.model_name
    ActiveModel::Name.new(Portfolio)
  end

  # Public: Loads investment data from Yahoo for each associated investment
  #
  # Returns self.
  def load_investments!
    symbols = self.investments.pluck(:symbol)
    quotes_lookup = YahooStock::Quote.new(stock_symbols: symbols, read_parameters: [:symbol, :last_trade_price_only])
    quotes = quotes_lookup.results(:to_hash).output
    self.investments.each do |investment|
      quote = quotes.select { |q| q[:symbol] == investment.symbol }
      investment.quote = quote.first
    end
    self
  end
end