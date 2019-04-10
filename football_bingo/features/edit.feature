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
<<<<<<< HEAD
  When I go to the edit page for "newuser"
  Then I should see "Update your profile"
=======
  When I follow "Settings"
  Then I should be on the edit page for "admin"
  Then I should see "Update your profile" 
>>>>>>> 1cfe184c08e53a5d66e5f9636cb9d33110fe4aca
  Then I fill in "Name" with "newname"
  And I fill in "Email" with "newemail@whoop.com"
  And I fill in "Password" with "newpassword"
  And I fill in "Confirmation" with "newpassword"
  And I press "Save changes"
  Then I should see "User was successfully updated."

Scenario: Edit with unmatched password
  Given the account is set up
  When I go to the edit page for "newuser"
  Then I should see "Update your profile"
  Then I fill in "Password" with "newpassword"
  And I fill in "Confirmation" with "newpassword1"
  And I press "Save changes"
  Then I should see "Password confirmation doesn't match"
