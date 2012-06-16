class PortfoliosController < ApplicationController
  def index
    @portfolios = current_user.portfolios.all
  end

  def show
    @portfolio = current_user.portfolios.find(params[:id])
  end

  def add_investment
    @portfolio = current_user.portfolios.find(params[:id])

    if params[:symbol].present?
      yahoo_quote_lookup = YahooStock::Quote.new(stock_symbols: params[:symbol], read_parameters: [:symbol, :name])
      stock = yahoo_quote_lookup.results(:to_hash).output.first
      logger.debug("Y: #{yahoo_quote_lookup}\nS: #{stock}")

      raise "Symbol not found" if stock[:symbol].nil?

      investment = Investment.find_or_create_by_symbol_and_name(stock[:symbol], stock[:name])
      @portfolio.investments << investment

      redirect_to @portfolio, :notice => "Investment #{investment[:name]} added!"
    else
      raise "No stock symbol present"
    end
  end
end
