def create_visitor_as_user
  @visitor ||= { :name => "DamonAlbarn", :email => "song2@blur.com",
    :password => "123456", :password_confirmation => "123456", :role => "user" }
end

def create_visitor_as_admin
  @visitor ||= { :name => "super_user", :email => "example@example.com",
    :password => "123456", :password_confirmation => "123456", :role => "admin" }
end

def find_user
  @user ||= User.first conditions: {:email => @visitor[:email]}
end

def delete_user
  @user ||= User.first conditions: {:email => @visitor[:email]}
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/signup'
  fill_in "Name", :with => @visitor[:name]
  fill_in "Email", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  fill_in "Password confirmation", :with => @visitor[:password_confirmation]
  click_button "Create my account"
  find_user
end

def log_in
  visit '/login'
  fill_in "Email", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  click_button "Log in"
end

def create_user
  create_visitor_as_user
  # delete_user
  @user = FactoryBot.create(:user, email: @visitor[:email])
end

def create_admin
  create_visitor_as_admin
  delete_user
  @user = FactoryBot.create(:user, email: @visitor[:email])
end

### GIVEN ###
Given /^I am not logged in$/ do
	click_link "Log out"
end

Given /^I am logged in as user$/ do
  create_user
  log_in
end

Given /^I exist as a user$/ do
  create_user
  log_in
end

Given /^I do not exist as a user$/ do
  create_visitor_as_user
  # delete_user
end

When /^I log in with valid credentials$/ do
	create_visitor_as_user
	log_in
end

When /^I log in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  log_in
end

When /^I log in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  log_in
end

Then /^I should be logged in$/ do
  page.should have_content "Log out"
  page.should_not have_content "Sign up"
  page.should_not have_content "Log in"
end

Then /^I should be logged out$/ do
  page.should have_content "Sign up"
  page.should have_content "Log in"
  page.should_not have_content "Log out"
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email/password combination"
end

Then /^I should see my name$/ do
  page.should have_content @user[:name]
end
