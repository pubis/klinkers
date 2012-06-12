Feature: Login with email
	Background:
		Given a user "mickey" with email "mickey@disney.com" and password "mouse" and an account

	Scenario:
		When I go to "/login"
		And I fill in "username_or_email" with "mickey@disney.com"
		And I fill in "password" with "mouse"
		And I click "Log in"
		Then I should see "Logged in"