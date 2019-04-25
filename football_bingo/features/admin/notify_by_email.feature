Feature: Notify winners by email

  As a admin user
  So that I can notify winners how to collect their prizes
  I want to send email to winners

Scenario: Go to score board
  Given I exist as an admin  
  And a finished game which I played before exists
  And I am a whoop winner
  When I am on the score board page
  And I send the email
  Then I should see "Winners are notified!"
  And I should see my name
