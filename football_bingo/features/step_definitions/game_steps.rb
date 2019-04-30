def create_ongoing_game
	@game = FactoryBot.create(:game, :is_ongoing)
end

def create_finished_game
	@game = FactoryBot.create(:game, :is_finished)
end

def create_upcoming_game
	@game = FactoryBot.create(:game, :is_upcoming)
end

def update_game_info
    @hometeam = FactoryBot.create(:team, :tamu)
    @visteam = FactoryBot.create(:team, :rice)
    @hometotal = FactoryBot.create(:total, :team => @hometeam, :game => @game)
    @vistotal = FactoryBot.create(:total, :team => @visteam, :game => @game)
    @vistc0 = FactoryBot.create(:totalcondition, :total => @vistotal, :translation => @trans0)
    @hometc0 = FactoryBot.create(:totalcondition, :value => 100, :total => @hometotal, :translation => @trans1)
end

def create_trans
	@trans0 = FactoryBot.create(:translation, :penalty_yds)
	@trans1 = FactoryBot.create(:translation, :firstdowns_no)
end

def dispatch_chips
	Chip.all.each do |c|
		@trans1.chips << c
		@game.chips << c
	end
end

def create_whoop_chips
	create_trans
	FactoryBot.create(:chip, :median, :value => 30)	
	FactoryBot.create(:chip, :median, :value => 30)
	FactoryBot.create(:chip, :lower, :value => 30)
	FactoryBot.create(:chip, :lower, :value => 100)
	FactoryBot.create(:chip, :higher, :value => 0)
	FactoryBot.create(:chip, :median, :value => 34)
	FactoryBot.create(:chip, :low, :value => 34)
	FactoryBot.create(:chip, :high, :value => 34)

	dispatch_chips
end

def create_non_whoop_chips
	create_trans

	FactoryBot.create(:chip, :median, :value => 100)
	FactoryBot.create(:chip, :median, :value => 30)
	FactoryBot.create(:chip, :lower, :value => 30)
	FactoryBot.create(:chip, :lower, :value => 100)
	FactoryBot.create(:chip, :higher, :value => 0)
	FactoryBot.create(:chip, :midian, :value => 34)

	dispatch_chips
end

def	create_random_chips
	create_trans
	FactoryBot.create_list(:chip, 50, :median, :value => 100)
	FactoryBot.create_list(:chip, 50, :low, :value => 30)
	FactoryBot.create_list(:chip, 50, :lower, :value => 30)
	FactoryBot.create_list(:chip, 50, :higher, :value => 0)
	FactoryBot.create_list(:chip, 50, :high, :value => 34)

	dispatch_chips
end

def create_non_whoop_chips
	create_trans

	FactoryBot.create(:chip, :median, :value => 100)
	FactoryBot.create(:chip, :median, :value => 30)
	FactoryBot.create(:chip, :lower, :value => 30)
	FactoryBot.create(:chip, :lower, :value => 100)
	FactoryBot.create(:chip, :higher, :value => 0)
	FactoryBot.create(:chip, :median, :value => 34)

	dispatch_chips
end

def set_played	
	@gameuser = FactoryBot.create(:game_user, :player)
	@gameuser.update(:game => @game)
	@gameuser.update(:user => @user)
end

def set_whoop_winner
	@gameuser.update(:state => "whoop_winner")
end

def set_instant_winner
	@gameuser.update(:state => "instant_winner")
end

def join
  visit '/games'
  click_on "Play!"
end

### GIVEN ###
Given /^a game exists$/ do
	create_ongoing_game
end

Given /^the game has more information$/ do
	update_game_info
end

Given /^an ongoing game which I never play exists$/ do
	create_ongoing_game
end

Given /^an ongoing game which I played before exists$/ do
	create_ongoing_game
	set_played
end

Given /^an upcoming game exists$/ do
	create_upcoming_game
end

Given /^a finished game which I played before exists$/ do
	create_finished_game
	set_played
end

Given /^a finished game which I never played before exists$/ do
	create_finished_game
end

Given /^I am a whoop winner$/ do
	set_whoop_winner
end

Given /^I am a instant winner$/ do
	set_instant_winner
end

Given /^I joined a game for the first time$/ do
	create_ongoing_game
	join
end

### WHEN ###
When /^I joined a game again$/ do
	create_ongoing_game
	set_played
	join
end

When /^I play the game$/ do
	join
end

When /^I want to know more about the game$/ do
	click_link "More about"
end

When /^I get a new card$/ do
	create_random_chips
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
	click_on "More about"
end

### THEN ###
Then /^I should see the name of the game$/ do
  page.should have_content @game[:game_name]
end

Then /^I should see the date of the game$/ do
  page.should have_content @game[:date]
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
  page.should have_content "More about"
end

Then /^I should not see the name of the game$/ do
	page.should_not have_content @game[:game_name]
end

Then /^I see the right whoop card$/ do
	page.should have_content @trans1[:words]
end

Then /^I see the right card$/ do
	page.should have_content @trans1[:words]
end

Then /^I should see the right info of the game$/ do
	page.should have_content "Overall Team Statistics"
	page.should have_content @visteam.name
	page.should have_content @hometeam.name
	page.should have_content @vistc0.value
	page.should have_content @hometc0.value
	page.should have_content @vistotal.totoff_plays 
	page.should have_content @hometotal.totoff_plays
	page.should have_content @vistotal.totoff_yards
end

