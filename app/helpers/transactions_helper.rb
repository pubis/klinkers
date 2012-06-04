module TransactionsHelper
  def transaction_category(transaction)
    if transaction.categories.uniq.size > 1
      "Multiple/Split"
    else
      if transaction.categories.any?
        link_to transaction.categories.first.display_name, transaction.categories.first
      else
        "No category"
      end
    end
  end

  def transaction_payee(transaction, account)
    remote = transaction.remote_accounts(account).first
    if remote && remote.type != 'Payee'
      link_to remote.name, remote
    else
      if remote.type == 'Payee'
        remote.name
      else
        "-"
      end
    end
  end
  
  def transaction_memo(transaction, account)
    i = transaction.account_items(account).first
    i.memo
  end

  def transaction_amount(transaction, account)
    is = transaction.account_items(account)
    amount = 0
    is.map { |i| amount += i.amount}
    amount
  end
end