class BudgetCategoriesController < ApplicationController
  def create
    @budget = current_user.budgets.find(params[:budget_id])
    @budget_category = @budget.budget_categories.create(params[:budget_category])
    
    respond_to do |format|
      if @budget_category.save
        format.html { redirect_to @budget, :notice => "Category added!" }
        format.json { render json: @budget_category }
      else
        format.html { render "new" }
        format.json { render json: @budget_category.errors, status: :unprocessable_entity }
      end
    end
  end
end