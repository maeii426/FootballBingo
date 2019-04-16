namespace :import do
	desc 'import game from XML'
	task :getxmlgame => :environment do
		require 'nokogiri'
		require 'date'
		doc = Nokogiri::XML(open("./XML/tam.xml"))
		doc.css('fbgame').each do |node|
			children = node.children

			game_param = {

				:date => Date.strptime(children.css('venue').first['date'], '%m/%d/%Y'),
				:source => node['source'],
				:version => node['version'],
				:generated => node['generated'],
				:hometeam => children.css('venue').first['homeid'],
				:visteam => children.css('venue').first['visid'],
						# :gamename => :hometeam_id + " vs " + :visteam_id
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

			children.css('team').first do |t|
				ls = t.children
				linescore_param = {
					:prds => ls['prds'].to_i,
					:score => ls['score'].to_i
				}
				linescore = Linescore.new(linescore_param) 
				linescore.save
				linescore.update_attributes(:game => game)
				game.update_attributes(:linescore =>linescore)
			end

			children.css('venue').each do |v|
				venue_param = {
					:gameid => v['gameid'].to_i,
					:date => v['date'],
					:attend => v['attend'],
					:location => v['location']
				}
				venue = Venue.new(venue_param) 
				venue.save
				venue.update_attributes(:game => game)
				game.update_attributes(:venue => venue)
			end

		end
	end
end
				