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
    #@account = current_user.accounts.new
  end
  
  def create
    @account = current_user.accounts.new(params[:account])
    
    if @account.save
      redirect_to @account, :notice => "Account succesfully created!"
    else
      flash.now.alert "Could not create account!"
      render "new"
    end
  end
end