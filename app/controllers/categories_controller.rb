class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
    if params[:parent] && parent = current_user.categories.find(params[:parent])
      @category.parent_id = parent.id
      @category.expense = parent.expense
    end
  end

  def edit
  end

  def create
    # Force current locale
    @category.locale = I18n.locale.to_s
    
    if @category.save
      redirect_to @category, :notice => "Category created!"
    else
      render "new"
    end
  end
  
  def update
    # Force current locale
    params[:category][:locale] = I18n.locale.to_s
    
    if @category.update_attributes(params[:category])
      redirect_to @category, :notice => "Category updated!"
    else
      render "edit"
    end
  end
  
  def destroy
    @category.destroy
    redirect_to categories_path, :alert => "Category deleted!"
  end
end