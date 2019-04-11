# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin_users = [{:name => 'admin', :email => 'admin@gmail.com', :password => '123456', :role => :admin},]
admin_users.each do |admin_user|
    User.create!(admin_user)
end

general_users = [{:name => 'Frank Flanigan', :email => 'whoop606super@gmail.com', :password => '123123', :role => :user},]
general_users.each do |general_user|
    User.create!(general_users)
end

games = [{:game_name => 'TAMU10', :date => '24-Nov-2018', :instant_winner => 'Jeffrey Hoberman', :whoop_winner => 'Frank Flanigan',:notify_by_email => 0},
    	 {:game_name => 'TAMU12', :date => '10-Nov-2018', :notify_by_email => 0},
	]

games.each do |game|
  Game.create!(game)
end

# translations = [{:tag => 'penalties_yds', :words => 'Number of penalty yards'},
#     	 {:tag => 'firstdowns_no', :words => 'Total first downs'},
#     	 {:tag => 'totals_totoff_yards', :words => 'Total offensive yards gained'},
#     	 {:tag => 'fg_made', :words => 'Number of field goals made'},
#     	 {:tag => 'empty', :words => 'Some condition here'},
#   	 ]

# translations.each do |translation|
#   Translation.create!(translation)
# end

# chips = [{:chip_id => '1', :translation_id => '1', :argument => '>', :value => 100},
#     	 {:chip_id => '2', :translation_id => '2', :argument => '>', :value => 30},
#     	 {:chip_id => '3', :translation_id => '3', :argument => '>', :value => 500},
#     	 {:chip_id => '4', :translation_id => '4', :argument => '>', :value => 2},
#     	 {:chip_id => '5', :translation_id => '5', :argument => '>', :value => 0},
#   	 ]

@trans = Translation.create!({:tag => 'penalties_yds', :words => 'Number of penalty yards'})
@trans.chips.create(:argument => '>', :value => 100)

@trans = Translation.create!({:tag => 'firstdowns_no', :words => 'Total first downs'})
@trans.chips.create(:argument => '>', :value => 30)

@trans = Translation.create!({:tag => 'totals_totoff_yards', :words => 'Total offensive yards gained'})
@trans.chips.create!(:argument => '>', :value => 500)

@trans = Translation.create!({:tag => 'fg_made', :words => 'Number of field goals made'})
@trans.chips.create!(:argument => '>', :value => 2)

@trans = Translation.create!({:tag => 'empty', :words => 'Some condition here'})
@trans.chips.create!(:argument => '>', :value => 0)

# chips.each do |chip|
#   Chip.create!(chip)
# end

cards = [{:user_id => '1'},
    ]

cards.each do|card|
    @card = Card.create!(card)
    #@card.chip_ids = card.chip_ids < chip.id
    @card.chip_ids = [1,2,3,4,5,5,5,5,5]
    @card.save
end

    # chip.card_ids = chip.card_ids < card.id
    # chip.save

# card_chips = [{:card_id => '1', :chip_id => '1'},
#   {:card_id => '1', :chip_id => '2'},
#   {:card_id => '1', :chip_id => '3'},
#   {:card_id => '1', :chip_id => '4'},
#   {:card_id => '1', :chip_id => '5'},
#   {:card_id => '1', :chip_id => '5'},
#   {:card_id => '1', :chip_id => '5'},
#   {:card_id => '1', :chip_id => '5'},
#   {:card_id => '1', :chip_id => '5'},
#     ]

# card_chips.each do|cc|
#     Cards_Chips.create!(cc)
# end
