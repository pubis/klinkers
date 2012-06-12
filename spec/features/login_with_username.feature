Feature: Login with username
	Background:
		Given a user "donald" with password "duckduck" and an account

	Scenario:
		When I go to "/login"
		And I fill in "username_or_email" with "donald"
		And I fill in "password" with "duckduck"
		And I click "Log in"
		Then I should see "Logged in"