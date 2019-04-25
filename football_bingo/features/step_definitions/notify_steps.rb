Given("I am the administrator") do
  User.create!({:name => 'admin',
                :password => '123456',
                :email => 'admin@gmail.com',
                :role => 'admin'})

  visit '/login'
  fill_in 'Email', :with => 'admin@gmail.com'
  fill_in 'Password', :with => '123456'
  click_button 'Log in'
end
