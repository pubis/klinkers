if Rails.env.development?
  # Account children
  %w[payee portfolio loan credit_card].each do |c|
    require_dependency File.join("app","models", "account","#{c}.rb")
  end

  # Transaction children
  %w[transfer withdrawal deposit].each do |c|
    require_dependency File.join("app","models", "transaction","#{c}.rb")
  end
end