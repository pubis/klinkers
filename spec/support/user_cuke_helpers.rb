module UserCukeHelpers
  def login_as(username_or_email, password)
    fill_in 'username_or_email', :with => username_or_email
    fill_in 'password', :with => password
    click_button :submit
  end

  def manual_login
    visit login_path
    login_as @me.username, @me.password
  end
end

RSpec.configure { |c| c.include UserCukeHelpers }