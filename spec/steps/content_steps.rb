module ContentSteps
  step "I should see :content" do |content|
    page.should have_content(content)
  end
end