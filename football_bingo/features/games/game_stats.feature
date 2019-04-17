Feature: See game stats

	As a competitive player
	I would like to see game stats
	so I know my chances of earning certain chips

Scenario: Go to game stats
  Given the account is set up
  And the game stats exist
  When I follow "Game Stats"
  Then I should see "Game Statistics"
 