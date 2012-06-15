class PortfoliosController < ApplicationController
  def index
    @portfolios = current_user.portfolios.all
  end

  def show
    @portfolio = current_user.portfolios.find(params[:id])
  end
end
