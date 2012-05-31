if Rails.env.development?
  %w[payee portfolio].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end