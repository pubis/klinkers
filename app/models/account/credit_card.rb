class CreditCard < Account
  def available
    balance + credit_limit.to_s.to_d
  end
end