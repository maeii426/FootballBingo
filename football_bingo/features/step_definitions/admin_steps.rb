Given /^I am the administrator$/ do
  visit '/login'
  fill_in 'Email', :with => 'admin@gmail.com'
  fill_in 'Password', :with => '123456'
  click_button 'Log in'
end
