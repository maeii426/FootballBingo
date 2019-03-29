# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
games = [{:gameid => 'TAMU10', :date => '24-Nov-2018', :instant_winner => 'Jeffrey Hoberman', :whoop_winner => 'Frank Flanigan'},
    	 {:gameid => 'TAMU12', :date => '10-Nov-2018'},
	]

games.each do |game|
  Game.create!(game)
end

chips = [{:chipid => '1', :conditional => 'penalties_yds', :argument => '>', :value => 100},
    	 {:chipid => '2', :conditional => 'firstdowns_no', :argument => '>', :value => 30},
    	 {:chipid => '3', :conditional => 'totals_totoff_yards', :argument => '>', :value => 500},
    	 {:chipid => '4', :conditional => 'fg_made', :argument => '>', :value => 2},
    	 {:chipid => '5', :conditional => 'empty', :argument => '>', :value => 0},
  	 ]

chips.each do |chip|
  Chip.create!(chip)
end

cards = [{:cardid => '1', :b11 => '1', :b12 => '2', :b13 => '5', :b21 => '3', :b22 => '5', :b23 => '5', :b31 => '4', :b32 => '5', :b33 => '5'},
    ]
    
cards.each do|card|
    Card.create!(card)
end