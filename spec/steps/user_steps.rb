module UserSteps
  step "a user :user with password :password and an account" do |user, password|
    u = FactoryGirl.create(:user, :username => user, :password => password)
    FactoryGirl.create(:account, :user => u)
  end

  step "a user :user with email :email and password :password and an account" do |user, email, password|
    u = FactoryGirl.create(:user, :username => user, :email => email, :password => password)
    FactoryGirl.create(:account, :user => u)
  end
end