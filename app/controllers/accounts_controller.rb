class AccountsController < ApplicationController
  load_and_authorize_resource :except => [:create]
  
  def index
  end
  
  def show
    @transactions = @account.transactions.paginate(:page => params[:page], :per_page => 15)
    
    @transaction = @account.transactions.new
    @transaction.transaction_items.build
  end
  
  def new
  end
  
  def edit
  end
  
  def create
    class_name = params[:account][:type].constantize
    @account = class_name.new(params[:account].except(:type))
    @account.user = current_user
    
    if @account.save
      redirect_to @account, :notice => "Account succesfully created!"
    else
      render "new"
    end
  end

  def update
    if @account.update_attributes(params[:account])
      redirect_to @account, :notice => "Account saved!"
    else
      render "edit"
    end
  end
end