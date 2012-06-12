module CurrencySteps
  step "there is a currency :name" do |name|
    FactoryGirl.create(:currency, :name => name)
  end
end