Feature: See share page
 
  As a user
  So that I can share this game to my friends
  I want to see a share page

Scenario: Go to share page
  Given the account is set up
  When I follow "Share"
  Then I should see "Share" 