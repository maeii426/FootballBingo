def create_game
	@game = FactoryBot.create(:game)
end

def update_game_info
    @hometeam = FactoryBot.create(:team0)
    @visteam = FactoryBot.create(:team1)

    @hometotal = FactoryBot.create(:total, :team => @hometeam, :game => @game)
    @vistotal = FactoryBot.create(:total, :team => @visteam, :game => @game)
    @vistc0 = FactoryBot.create(:totalcondition, :total => @vistotal, :translation => @trans0)
    @hometc0 = FactoryBot.create(:totalcondition, :value => 100, :total => @hometotal, :translation => @trans1)

end

def create_trans
	@trans0 = FactoryBot.create(:translation)
	@trans1 = FactoryBot.create(:translation, :tag => 'firstdowns_no', :words => 'Total first downs')
end

def create_whoop_chips
	create_trans
	@chip0 = FactoryBot.create(:median_chip, :value => 30, :game => @game)
	@chip0.update(:translation => @trans1, :game => @game)
	
	@chip1 = FactoryBot.create(:median_chip, :value => 30, :game => @game)
	@chip1.update(:translation => @trans1)

	@chip2 = FactoryBot.create(:lower_chip, :value => 30, :game => @game)
	@chip2.update(:translation => @trans1)
	@chip2.set_level

	@chip3 = FactoryBot.create(:lower_chip, :value => 100, :game => @game)
	@chip3.update(:translation => @trans1)
	@chip3.set_level

	@chip4 = FactoryBot.create(:higher_chip, :value => 0, :game => @game)
	@chip4.update(:translation => @trans1)
	@chip4.set_level

	@chip5 = FactoryBot.create(:median_chip, :value => 34, :game => @game)
	@chip5.update(:translation => @trans1)
	@chip5.set_level

	@chip6 = FactoryBot.create(:low_chip, :value => 34, :game => @game)
	@chip6.update(:translation => @trans1)
	@chip6.set_level

	@chip7 = FactoryBot.create(:high_chip, :value => 34, :game => @game)
	@chip7.update(:translation => @trans1)
	@chip7.set_level
end

def create_non_whoop_chips
	create_trans

	@chip0 = FactoryBot.create(:median_chip, :value => 100, :game => @game)
	@chip0.update(:translation => @trans1, :game => @game)
	
	@chip1 = FactoryBot.create(:median_chip, :value => 30, :game => @game)
	@chip1.update(:translation => @trans1)

	@chip2 = FactoryBot.create(:lower_chip, :value => 30, :game => @game)
	@chip2.update(:translation => @trans1)

	@chip3 = FactoryBot.create(:lower_chip, :value => 100, :game => @game)
	@chip3.update(:translation => @trans1)

	@chip4 = FactoryBot.create(:higher_chip, :value => 0, :game => @game)
	@chip4.update(:translation => @trans1)

	@chip5 = FactoryBot.create(:median_chip, :value => 34, :game => @game)
	@chip5.update(:translation => @trans1)
end

def set_played
	@gameuser = FactoryBot.create(:game_user)
	@gameuser.update(:game => @game)
	@gameuser.update(:user => @user)
end

def set_whoop_winner
	@gameuser.update(:state => "whoop_winner")
end

def set_instant_winner
	@gameuser.update(:state => "instant_winner")
end

def set_finished
	@game.update(:state => "finished")
end

def set_upcoming
	@game.update(:state => "upcoming")
end

def join
  visit '/games'
  click_button "Play!"
end

Given /^the game stats exist$/ do
	create_game
end

Given /^the following games exist$/ do |games_table|
  games_table.hashes.each do |game|
    Game.create game
  end
end

Then /^I should see "(.*)" before "(.*)"$/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

Given /^a game exists$/ do
	create_game
end

Given /^the game has more information$/ do
	update_game_info
end

Given /^an ongoing game which I never play exists$/ do
	create_game
end

Given /^an ongoing game which I played before exists$/ do
	create_game
	set_played
end

Given /^an upcoming game exists$/ do
	create_game
	set_upcoming
end

Given /^a finished game which I played before exists$/ do
	create_game
	set_played
	set_finished
end

Given /^I am a whoop winner$/ do
	set_whoop_winner
end

Given /^I am a instant winner$/ do
	set_instant_winner
end

Given /^I joined a game for the first time$/ do
	create_game
	join
end

When /^I joined a game again$/ do
	create_game
	set_played
	join
end

When /^I play the game$/ do
	join
end

When /^I want to know more about the game$/ do
	click_link "More about " + @game[:game_name]
end

When /^I get a new card$/ do
 	click_on "Get a new card!"
end

When /^I get a new whoop card$/ do
 	create_whoop_chips
 	click_on "Get a whoop card!"
end

When /^I get a new non-whoop card$/ do
	create_non_whoop_chips
	click_on "Get a whoop card!"
end

When /^I press the more info of the game$/ do
	click_on "More about " + @game[:game_name]
end

Then /^I should see the name of the game$/ do
  page.should have_content @game[:game_name]
end

Then /^I should see the date of the game$/ do
  page.should have_content @game[:date].to_date
end

Then /^I should see the hometeam of the game$/ do
  page.should have_content @game[:hometeam]
end
Then /^I should see the visiting team of the game$/ do
  page.should have_content @game[:visteam]
end

Then /^I should see the status of the game$/ do
  	if @game[:state] == "ongoing"
  		page.should have_content "Ongoing"
  	elsif @game[:state] == "finished"
		page.should have_content "Finished"
	else
		page.should have_content "Upcoming"
	end
end

Then /^I should see the more info of the game$/ do
  page.should have_content "More about " + @game[:game_name]
end

Then /^I should not see the name of the game$/ do
	page.should_not have_content @game[:game_name]
end

Then /^I see the right whoop card$/ do
	page.should have_content @trans1[:words]
end

Then /^I should see the right info of the game$/ do
	page.should have_content @visteam.name
	page.should have_content @hometeam.name
	page.should have_content @vistc0.value
	page.should have_content @hometc0.value
	page.should have_content @vistotal.totoff_plays 
	page.should have_content @hometotal.totoff_plays
	page.should have_content @vistotal.totoff_yards

end

