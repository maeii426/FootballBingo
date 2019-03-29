Feature: See active card
 
  As a competitive player
  I want to see the active card
 
Scenario: Go to active card
  Given the account is set up
  When I am on the active card page
  Then  I should see "BINGO"  