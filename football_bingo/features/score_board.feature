Feature: See score board

  As a competitive player
  So that I know who won prizes
  I want to see a score board

Background: games are in the database

  Given the following games exist:
  | game_name | date | instant_winner | whoop_winner | 
  | TAMU10 | 24-Nov-2018 | Jeffrey Hoberman |   Frank Flanigan |
  | TAMU12 | 10-Nov-2018|   |   |

Scenario: Go to score board
  Given the account is set up
  When I am on the score board page
  Then  I should see "Congratulations!"
