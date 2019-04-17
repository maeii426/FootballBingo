Feature: See profile page

  As a user
  I want to see the profile page

Scenario: Go to profile
  Given the account is set up
  When I am on the profile page for "newuser"
  Then  I should see "All active bingo cards associated with this user"
