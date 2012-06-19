module FormSteps
  step "I fill in :field with :value" do |field, value|
    fill_in field, :with => value
  end
  
  step "I select :option as :select" do |option, select|
    select(option, :from => select)
  end
end


RSpec.configure { |c| c.include FormSteps }