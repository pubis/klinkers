class TransactionsController < ApplicationController
  def create
    @account = Account.find(params[:account_id])
    
    @transaction = @account.build_transaction(params[:transaction])
    
    respond_to do |format|
      if @transaction.save
        logger.debug("Transaction saved: #{@transaction.inspect}")
        format.html { redirect_to @account, :notice => "Transaction saved!" }
        format.json { render json: @transaction }
      else
        logger.debug("Transaction failed to save: #{@transaction.inspect}")
        format.html { render "new" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end
end