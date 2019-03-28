Feature: Login functionality
 
  As a user
  So that I can use Whoop
  I want to log in with username and password
  Background: users are in the database
 
  Given the following users exist:
  | name | password | email |
  | user0 | 12345678 | user0@whoop.com |
  | user1 | 00000000 | user1@whoop.com | 

Scenario: Logging in with valid credentials
  Given I am on the log in page
  When I fill in "Email" with "user0@whoop.com"
  When I fill in "Password" with "12345678"
  And I press "Log in"
  Then I should see "user0"
  
Scenario: Logging in with invalid credentials
  Given I am on the log in page
  When I fill in "Email" with "user1@whoop.com"
  When I fill in "Password" with "12345678"
  And I press "Log in"
  Then I should see "Invalid email/password combination"