Feature: Create a new portfolio
	Background:
		Given I am logged in as a user

	Scenario:
		When I go to "/accounts/new"
		And I choose "Portfolio" as "Type"
		And I fill in "Name" with "StocksAndStuff"
		And I fill in "Opening balance" with "25000"
		And I click "Save account"
		Then I should see "Portfolio created"
		And I should see "StocksAndStuff"