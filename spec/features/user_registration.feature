Feature: Sign up as a new user
	Background:
		Given there is a currency "Monopoly Money"
		And I go to "the front page"
		And I click "sign up"

	Scenario:
		When I fill in "Username" with "mrawesome"
		And I fill in "Email" with "awesome@example.com"
		And I select "English" as "Language"
		And I select "Monopoly Money" as "Currency"
		And I fill in "Password" with "secret"
		And I fill in "user_password_confirmation" with "secret"
		And I click "Create user"
		Then I should see "user created"