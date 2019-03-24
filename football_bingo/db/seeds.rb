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
