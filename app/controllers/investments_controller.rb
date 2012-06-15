class InvestmentsController < ApplicationController
  def index
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
  end

  def show
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
  end

  def search
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
    @symbols = []

    if params[:q].present?
      symbols = YahooStock::ScripSymbol.new(params[:q])
      @symbols = symbols.results(:to_hash).output
      logger.debug "Symbols fetched: #{@symbols}"
    end
  end

  def create
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
  end
end
