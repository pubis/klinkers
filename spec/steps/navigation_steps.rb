module NavigationSteps
  step "I am on the front page" do
    visit "/"
  end

  step "I click :button" do |button|
    click_on button
  end

  step "I go to :path" do |path|
    visit path
  end
end