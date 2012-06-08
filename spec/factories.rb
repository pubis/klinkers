FactoryGirl.define do
  
  factory :currency do
    sequence(:code) { |n| "C#{n}" }
    name { "Currency #{code}" }
    locale "en"
  end
  
  factory :user do
    currency
    sequence(:username) { |n| "foo#{n}" }
    email { "#{username}@example.com" }
    password "foobar"
    password_confirmation { password }
  end
  
  factory :account do
    user
    sequence(:name) { |n| "foo#{n}" }
  end
  
  factory :payee do
    user
    sequence(:name) { |n| "#{n} payee" }
  end

  factory :credit_card do
    user
    sequence(:name) { |n| "CreditCard #{n}" }
    credit_limit 50_000
  end
end