Feature: Go to users index
 
  As an admin
  I want to see a list of users
  So that I can manage them 

Scenario: Go to index page
  Given the account is set up
  When I am on the users page
  Then I should see "Cannot access"  