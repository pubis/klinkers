Feature: economy overview
	In order to get a summarized view of my entire economy
	As a user
	I want an overview page

	Background:
		Given a user with username "scrooge" with an account named "Money Bin"
		And I sign in as "scrooge"

	Scenario: 
		When I go to "the overview page"
		Then I should see "My economy"
		And I should see "Money Bin"