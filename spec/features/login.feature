Feature: Signing in

	Background:
		Given a user "mickey" with email "mickey@disney.com" and password "mouse" and an account
		And I go to "the login page"

	Scenario: with email
		When I fill in "username_or_email" with "mickey@disney.com"
		And I fill in "password" with "mouse"
		And I click "Log in"
		Then I should see "Logged in"

	Scenario: with username
		When I fill in "username_or_email" with "mickey"
		And I fill in "password" with "mouse"
		And I click "Log in"
		Then I should see "Logged in"