class CreditCard < Account
  def available
    return balance + credit_limit
  end
end