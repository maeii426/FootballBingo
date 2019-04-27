Feature: Go to users index
 
  As an admin
  I want to see a list of users
  So that I can manage them 

Scenario: I cannot go to index page if I am not an admin user
  Given the account is set up
  When I am on the users page
  Then I should see "Welcome!"

Scenario: I can go to index page if I am an admin user
  Given another user exists
  And the admin account is set up
  When I am on the users page
  And I delete the other user
  Then the other user is deleted

