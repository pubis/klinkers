class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end
  
  def overview
    unless current_user
      redirect_to login_path
    end
    
    @accounts = current_user.accounts.users.no_payees
    
    account_ids = params[:accounts] || @accounts.map { |a| a.id }

    ids = account_ids.join(',')
    
    @start_date = Date.today.beginning_of_month
    @end_date = Date.today
    
    @categories = Category.all(
      :select => "categories.*, SUM(transaction_items.amount) AS amount",
      :joins => [
        "LEFT JOIN transaction_items ON categories.id = transaction_items.category_id AND transaction_items.account_id IN (#{ids})",
        "LEFT JOIN transactions ON transaction_items.transaction_id = transactions.id"
      ],
      :conditions => [
        "categories.expense = ? AND amount IS NOT NULL AND transactions.operation_date >= ? AND transactions.operation_date <= ?",
        true,
        @start_date,
        @end_date
      ],
      :group => "categories.id",
      :order => "amount ASC"
    )
    
    @net_worths = []
    sd = Date.today.beginning_of_year
    while sd <= Date.today
      nw = 0
      as = []
      @accounts.each do |a|
        b = a.balance_as_of sd
        nw += b
        as << {id: a.id, name: a.name, balance: b}
      end
      @net_worths << {
        date: sd,
        net_worth: nw,
        accounts: as
      }
      sd += 1.month
    end
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to login_path, :notice => "New user created! Please login!"
    else
      render "new"
    end
  end
  
  def update
    @user = current_user
    
    if @user.update_attributes(params[:user])
      redirect_to overview_path, notice: "Settings saved!"
    else
      render "new"
    end
  end
end