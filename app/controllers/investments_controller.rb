class InvestmentsController < ApplicationController
  def index
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
  end

  def show
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
  end

  def search
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
  end

  def create
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
  end
end
