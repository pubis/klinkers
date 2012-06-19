module SessionSteps
  step "I sign in as :user" do |user|
    @me = User.find_by_email(user) || User.find_by_username(user)
    @me.password ||= 'foobar'
    manual_login
  end
end

RSpec.configure { |c| c.include SessionSteps }