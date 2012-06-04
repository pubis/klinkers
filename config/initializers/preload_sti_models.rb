if Rails.env.development?
  # Account children
  %w[payee portfolio loan credit_card].each do |c|
    require_dependency File.join("app","models", "account","#{c}.rb")
  end

  %w[transfer withdrawal deposit].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end