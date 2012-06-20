FactoryGirl.define do
  
  factory :currency do
    sequence(:code) { |n| "C#{n}" }
    name { "Currency #{code}" }
    locale "en"
  end

  factory :category do
    sequence(:name) { |n| "Category #{n}"}

    factory :expense_category do
      expense true
    end

    factory :income_category do
      expense false
    end
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

  trait :system do
    system true
  end

  factory :credit_card do
    user
    sequence(:name) { |n| "CreditCard #{n}" }
    credit_limit 50_000
  end

  factory :transaction do
    ignore do
      amount 100
    end

    operation_date { Date.today }

    before(:create) do |transaction, evaluator|
      transaction.transaction_items << FactoryGirl.build(:transaction_item, amount: evaluator.amount)
      transaction.transaction_items << FactoryGirl.build(:transaction_item, amount: -evaluator.amount)
    end
  end

  factory :transaction_item do
    account
    category
    memo "a transaction item"
    amount 100
  end
end