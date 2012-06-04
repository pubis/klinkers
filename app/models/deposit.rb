class Deposit < Transaction
  def build_items(user, account, opts = {})
    transaction_items.new(
      category_id: opts[:category_id], 
      account_id: find_or_create_account(user, opts[:account]).id, 
      amount: opts[:amount].to_d * -1, 
      memo: opts[:memo]
    )
    transaction_items.new(
      category_id: opts[:category_id], 
      account_id: account.id, 
      amount: opts[:amount], 
      memo: opts[:memo]
    )
  end
end