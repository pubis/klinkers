module NavigationSteps
  step "I am on the front page" do
    visit "/"
  end
  
  step "I click :button" do |button|
    click_on button
  end
end