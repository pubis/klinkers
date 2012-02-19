class TransactionsController < ApplicationController
  def create
    @account = Account.find(params[:account_id])
    
    t = params[:transaction]
    
    case t[:event]
    when "Deposit" || "Transfer"
      t[:transaction_items_attributes]["0"][:amount] = t[:transaction_items_attributes]["0"][:amount].to_d * -1
    end
    
    if t[:event] == "Transfer"
      # Extract and find the id of the supplied account or create new if none exists
      account_name = t[:transaction_items_attributes]["0"][:to_account].blank? ? "Anonymous Account" : t[:transaction_items_attributes]["0"][:to_account]
      account = current_user.accounts.where(name: account_name).first_or_create!(opening_balance: 0)
      t[:transaction_items_attributes]["0"][:account_id] = account.id
    else
      # Extract and find the id of the supplied payee or create new if none exists
      payee_name = t[:transaction_items_attributes]["0"][:payee].blank? ? "Anonymous Payee" : t[:transaction_items_attributes]["0"][:payee]
      payee = current_user.accounts.where(name: payee_name).first_or_create!(payee: true, opening_balance: 0)
      t[:transaction_items_attributes]["0"][:account_id] = payee.id
    end

    @transaction = Transaction.new(t)

    # The remote transaction has already been built using nested attributes
    # so build the local transaction here...
    attrs = t[:transaction_items_attributes]["0"]
    attrs[:amount] = -1 * attrs[:amount].to_d
    attrs[:account_id] = @account.id
    from = @transaction.transaction_items.build(attrs)
    
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