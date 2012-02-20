class BudgetsController < ApplicationController
  load_and_authorize_resource
  
  def index
    
  end
  
  def new
    
  end
  
  def create
    if @budget.save
      redirect_to @budget, :notice => "Budget created!"
    else
      render "new"
    end
  end
end