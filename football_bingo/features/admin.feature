Feature: See admin panel

  As an admin user
  I would like to have a control panel
  so that I can view, edit, and delete the current database

Scenario: Current user is an admin user
  Given the admin account is set up
  When I follow "Admin"
  Then I should be on the admin page
  And I should see "Site Administration"

Scenario: Current user is not an admin user
  Given the account is set up
  Then I should not see "Admin"