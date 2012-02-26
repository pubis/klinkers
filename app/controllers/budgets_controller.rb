class BudgetsController < ApplicationController
  load_and_authorize_resource
  
  def index
    
  end
  
  def new
    
  end
  
  def show
    if params[:period]
      @period = @budget.budget_periods.find(params[:period])
    else
      @period = @budget.active_period
    end
    @budget_category = @budget.budget_categories.new
  end
  
  def create
    if @budget.save
      redirect_to @budget, :notice => "Budget created!"
    else
      render "new"
    end
  end
end