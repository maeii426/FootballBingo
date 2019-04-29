Feature: Sign up functionality
 
  As a user
  So that I can use Whoop
  I want to sign up to log in
  Background: users are in the database
 
  Given the following users exist:
  | name | password | email |
  | user0 | 12345678 | user0@whoop.com |
  | user1 | 00000000 | user1@whoop.com | 

Scenario: Sign up with new email
  Given I am on the sign up page
  When I fill in "Name" with "user2"
  When I fill in "Email" with "user2@whoop.com"
  When I fill in "Password" with "11111111"
  When I fill in "Password confirmation" with "11111111"
  And I press "Submit"
  Then I should see "user2"
  Then I should see "Welcome to the FootballBingo App!"

  
Scenario: Sign up with existing email
  Given I am on the sign up page
  When I fill in "Name" with "user0"
  When I fill in "Email" with "user0@whoop.com"
  When I fill in "Password" with "12345678"
  When I fill in "Password confirmation" with "12345678"
  And I press "Submit"
  Then I should see "Email has already been taken"
  
Scenario: Sign up with new email but wrong password confirmation
  Given I am on the sign up page
  When I fill in "Name" with "user2"
  When I fill in "Email" with "user2@whoop.com"
  When I fill in "Password" with "12345678"
  When I fill in "Password confirmation" with "00000000"
  And I press "Submit"
  Then I should see "Password confirmation doesn't match"