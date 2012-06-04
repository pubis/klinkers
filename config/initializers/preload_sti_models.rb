if Rails.env.development?
  %w[payee portfolio loan credit_card].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end

  %w[transfer withdrawal deposit].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end