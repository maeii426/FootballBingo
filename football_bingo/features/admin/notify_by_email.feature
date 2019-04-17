Feature: Notify winners by email

  As a admin user
  So that I can notify winners how to collect their prizes
  I want to send email to winners

Background: games are in the database

  Given the following games exist:
  | game_name | date | instant_winner | whoop_winner |  notify_by_email  |
  | TAMU10 | 24-Nov-2018 | Jeffrey Hoberman |   Frank Flanigan | 0 |
  | TAMU12 | 10-Nov-2018|   |   | 0 |

Scenario: Go to score board
  Given I am the administrator
  When I am on the score board page
  And  I press "Send" at "TAMU10"
  Then I should see "Winners are notified !"
