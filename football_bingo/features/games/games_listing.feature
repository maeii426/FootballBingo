Feature: See a list of all games

  As a user
  So that I can choose one game to play
  I want to see the list of all the games

Background: Login the user 
  Given I exist as a user

Scenario: Go to the list of all games
  When I follow "Games"
  Then I should be on the games page
  And I should see "All Games"

Scenario: I can see a list of games and their information
  Given a game exists
  When I am on the games page
  Then I should see the name of the game
  And I should see the date of the game
  And I should see the hometeam of the game
  And I should see the visiting team of the game
  And I should see the status of the game
  And I should see the more info of the game

Scenario: I can see more info of the game
  Given a game exists
  And the game has more information
  When I am on the games page
  And I press the more info of the game
  Then I should see "Overall Team Statistics"
  And I should see the right info of the game

Scenario: I cannot see a game I never play in my profile
  Given an ongoing game which I never play exists
  When I follow "Profile"
  Then I should not see the name of the game

Scenario: I can see a game I played in my profile
  Given an ongoing game which I played before exists
  When I follow "Profile"
  Then I should see the name of the game
  And I should see "Ongoing"
  And I should see "Try!"
  And I should see "Play!"

Scenario: A finished game
  Given a finished game which I played before exists
  When I follow "Profile"
  Then I should see "You have played 1 games and won 0 of them, 0 as an instant winner and 0 as a whoop winner"
  And I should see "Good Luck Next Time.."
  And I should see "Finished"
  And I should see "Check play history"

Scenario: An upcoming game
  Given an upcoming game exists
  When I am on the games page
  Then I should see "Upcoming"

Scenario: A finished game
  Given a finished game which I played before exists
  When I follow "Profile"
  And I press "Check play history"
  Then I should not see "Get a new card!"

Scenario: A finished game
  Given a finished game which I played before exists
  And I am a whoop winner
  When I follow "Profile"
  Then I should see "won 1 of them, 0 as an instant winner and 1 as a whoop winner"
  And I should see "Whoop Winner!"

Scenario: Instant winner
  Given a finished game which I played before exists
  And I am a instant winner
  When I follow "Profile"
  Then I should see "won 1 of them, 1 as an instant winner and 0 as a whoop winner"
  And I should see "Instant Winner!"

Scenario: Instant winner
  Given a finished game which I played before exists
  And I am a instant winner
  When I follow "Score Board"
  Then I should see my name

Scenario: More info
  Given a game exists
  When I follow "Profile"