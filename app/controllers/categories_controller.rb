class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
  end
  
  def show
    @accounts = current_user.accounts.users.no_payees
    account_ids = params[:accounts] || @accounts.map { |a| a.id }

    start_date = Date.today.beginning_of_year

    @months = []
    while start_date < Date.today
      item = TransactionItem.all(
        :select => "SUM(transaction_items.amount) AS amount",
        :joins => ["LEFT JOIN transactions ON (transactions.id = transaction_items.transaction_id)"],
        :conditions => [
          "transaction_items.account_id IN (?) AND transaction_items.category_id = ? AND transactions.operation_date > ? AND transactions.operation_date <= ?",
          account_ids,
          params[:id],
          start_date,
          start_date.end_of_month
        ],
        :group => "transaction_items.category_id"
      ).first
      @months << {
        title: "#{Date::MONTHNAMES[start_date.month].titleize} #{start_date.year}",
        start_date: start_date,
        end_date: start_date.end_of_month,
        amount: item.nil? ? 0.0 : item.amount.abs
      }
      start_date += 1.month
    end
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