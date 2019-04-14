namespace :import do
	desc 'import game from XML'
	task :getxmlgame => :environment do
		require 'nokogiri'
		doc = Nokogiri::XML(open("./XML/tam.xml"))
		doc.css('fbgame').each do |node|
			children = node.children

			game_param = {
				:date => children.css('venue')['date'],
				:source => node['source'],
				:version => node['version'],
				:generated => node['generated'],
				:hometeam_id => children.css('venue')['homeid'],
				:visteam_id => children.css('venue')['visid']
			}

			game = Game.new(game_param)
			game.save

			children.css('team').each do |t|
				team_param = {
					:name => t['name'],
					:nameid => t['id']
				}
				team = Team.new(team_param) 
				team.save
			end

			children.css('venue').each do |v|
				venue_param = {
					:gameid => v['gameid'],
					:date => v['date'],
					:attend => v['attend'],
					:location => v['location']

				}
				venue = Venue.new(venue_param) 
				venue.save
			end
			
		end
	end
end
				