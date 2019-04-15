Then("I should see {string}") do |string|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then("I should not see {string}") do |string|
  if page.respond_to? :should
    page.should have_no_content(string)
  else
    assert page.has_no_content?(string)
  end
end

Then("I press {string}") do |string|
  click_button(string)
end

When("I press {string} at {string}") do |string, string2|
  visit path_to('the send page')
  game = Game.find_by(game_name: string2)
  a=send_email_path(game)
end

When("I follow {string}") do |string|
  click_link(string)
end

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
