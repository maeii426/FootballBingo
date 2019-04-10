Feature: See admin panel

  As an admin user
  I would like to have a control panel
  so that I can view, edit, and delete the current database

Scenario: Current user is an admin user
  Given the admin account is set up
  When I am on the admin page
  Then I should see "user0"