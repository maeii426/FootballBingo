Feature: Edit profile

  As a user
  So that I can update my information
  I want to see an edit page

Scenario: Edit with wrong email format
  Given the account is set up
  When I go to the edit page for "newuser"
  Then I should see "Update your profile"
  Then I fill in "Name" with "newname"
  And I fill in "Email" with "newemail"
  And I fill in "Password" with "newpassword"
  And I fill in "Confirmation" with "newpassword"
  And I press "Save changes"
  Then I should see "Email is invalid"

  Scenario: Edit with correct information
  	  Given the account is set up
  	  When I go to the edit page for "newuser"
  	  Then I should see "Update your profile"
  	  Then I fill in "Name" with "newname"
  	  And I fill in "Email" with "newemail@whoop.com"
  	  And I fill in "Password" with "newpassword"

Scenario: Edit with unmatched password
  Given the account is set up
  When I go to the edit page for "newuser"
  Then I should see "Update your profile"
  Then I fill in "Password" with "newpassword"
  And I fill in "Confirmation" with "newpassword1"
  And I press "Save changes"
  Then I should see "Password confirmation doesn't match"
