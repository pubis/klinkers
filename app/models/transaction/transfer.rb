class Transfer < Transaction
  def find_or_create_account(u, a)
    # Find the id of the supplied account or create new if none exists
    account_name = a.blank? ? "Anonymous Account" : a
    account = u.accounts.where(name: account_name).first_or_create!(opening_balance: 0)
  end
end