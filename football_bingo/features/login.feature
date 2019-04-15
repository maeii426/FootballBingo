Feature: Login functionality
 
  As a user
  So that I can use Whoop
  I want to log in with username and password

Scenario: Logging in without sign up first
  Given I do not exist as a user
  When I log in with valid credentials
  Then I see an invalid login message
  And I should be logged out

Scenario: Logging in with valid credentials
  Given I exist as a user
  And I am not logged in
  When I log in with valid credentials
  Then I should be logged in
  And I should see my name

Scenario: Logging in with invalid credentials
  Given I exist as a user
  And I am not logged in
  When I log in with a wrong password
  Then I see an invalid login message
  And I should be logged out

Scenario: Logging in with invalid credentials
  Given I exist as a user
  And I am not logged in
  When I log in with a wrong email
  Then I see an invalid login message
  And I should be logged out  