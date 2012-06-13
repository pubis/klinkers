module UserSteps
  step "a user with username :username" do |username|
    FactoryGirl.create(:user, :username => username)
  end

  step "a user with username :username with a/an account named :account" do |username, account|
    u = FactoryGirl.create(:user, :username => username)
    FactoryGirl.create(:account, :user => u, :name => account)
  end

  step "a user :user with password :password and an account" do |user, password|
    u = FactoryGirl.create(:user, :username => user, :password => password)
    FactoryGirl.create(:account, :user => u)
  end

  step "a user :user with email :email and password :password and an account" do |user, email, password|
    u = FactoryGirl.create(:user, :username => user, :email => email, :password => password)
    FactoryGirl.create(:account, :user => u)
  end

  step "I am logged in as a user" do
    user = FactoryGirl.create(:user)
    visit login_path
    fill_in "username_or_email", with: user.username
    fill_in "password", with: user.password
    click_on "Log in"
  end
end
RSpec.configure { |c| c.include UserSteps }