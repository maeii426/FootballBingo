Feature: See profile page

  As a user
  I want to see the profile page

Scenario: Go to profile
  Given the account is set up
  When I am on the profile page for "newuser"
  Then I should see "newuser"

Scenario: Cannot go to profile unless logged in
  Given I exist as a user
  And I am not logged in
  When I visit my profile
  Then I should see "Please log in"
