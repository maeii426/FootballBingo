Feature: Show instructions
 
  As a user
  I want to read the instructions page
  So that I can know how to play this game

Scenario: Go to help
  Given the account is set up
  When I am on the help page
  Then  I should see "Help"  
