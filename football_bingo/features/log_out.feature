Feature: Log out sucessfully
  As a user
  I want to log out my account
  So that I can quit this website

Scenario: Go to log out
  Given the account is set up
  When I follow "Log out"
  Then I should see "Log in"