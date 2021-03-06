Feature: Join a game

  As an admin
  So that I can get bingo cards
  I want to join an ongoing game

Background: Login the user before every scenario
  Given I exist as an admin

Scenario: I can join an ongoing game for the first time
  Given an ongoing game which I never play exists
  When I play the game
  Then I should see "You play this game for the first time!"

Scenario: I joined the game before
  When I joined a game again
  Then I should see "You can continue this game!"
  And I should see "Show all the cards associated with this game"

Scenario: I got a whoop card
  Given I joined a game for the first time
  When I get a new whoop card
  Then I should see "Congrats! You just got a new card!"
  And I see the right whoop card

Scenario: I got a new card
  Given I joined a game for the first time
  When I get a new card
  Then I should see "Congrats! You just got a new card!"
  And I see the right card

Scenario: I get successful message if I win
  Given I joined a game for the first time
  When I get a new whoop card
  And I follow "Do I Win?"
  Then I should see "Whoop! You are the winner! Go to check score board!"

Scenario: I get failed message if I don't win
  Given I joined a game for the first time
  When I get a new non-whoop card
  And I follow "Do I Win?"
  Then I should see "Not yet. Good luck is on your way!"

Scenario: I can see the bingo card status of my self
  Given I joined a game for the first time
  When I get a new card with two chips which meet the conditions
  And I follow "Do I win?"
  Then I should see "You need one more chip!"