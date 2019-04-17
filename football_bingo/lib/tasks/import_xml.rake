namespace :import do
	desc 'import game from XML'
	task :getxmlgame => :environment do
		require 'nokogiri'
		require 'date'
		doc = Nokogiri::XML(open("./XML/tam.xml"))
		doc.css('fbgame').each do |node|
			sections = node.children

			game_param = {
				:date => Date.strptime(sections.css('venue').first['date'], '%m/%d/%Y'),
				:source => node['source'],
				:version => node['version'],
				:generated => node['generated'],
				:hometeam => children.css('venue').first['homeid'],
				:visteam => children.css('venue').first['visid'],
				# :gamename => :hometeam_id + " vs " + :visteam_id
			}

			game = Game.new(game_param)
			game.save
			
			sections.css('venue').first do |v|					# there should only be one venue
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

			sections.css('team').each do |t|					# there sould be two team sections
				team_param = {
					:name => t['name'],
					:nameid => t['id']
				}
				team = Team.new(team_param) 
				team.save
				
				team_stuff = t.children
				team_stuff.css('linescore').first do |ls|		# there should only be one per team!
					linescore_param = {
						:prds => ls['prds'].to_i,
						:score => ls['score'].to_i
					}
					linescore = Linescore.new(linescore_param) 
					linescore.save
					linescore.update_attributes(:game => game)
					linescore.update_attributes(:team => team)
					#game.update_attributes(:linescore =>linescore)
				
					ttt = ls.children
					ttt.css('lineprd').each do |lp|
						#UPDATE linescoreconditions to migration of lineprds for timestamps on the scores :)
					end
				end
				
				team_stuff.css('totals').first do |tot|			# there should only be one per team!
					total_param = {
						:qtr => "all",
						:totoff_plays => tot["totoff_plays"].to_i,
						:totoff_yards => tot["totoff_yards"].to_i,
						:totoff_avg => tot["totoff_avg"].to_f
					}
					total = Total.new(total_param) 
					total.save
					total.update_attributes(:game => game)
					total.update_attributes(:team => team)
					
					tot_misc = tot.children
					#loop through the different css values of totals and update totalconditions
					#   OR update the migrations to account for each of the conditions - and add translations as necessary
				end
				
				team_stuff.css('player').each do |py|
					player_param = {
						:name => py["name"],
						:shortname => py["shortname"],
						:class => py["class"]
					}	
					player = Player.new(player_param)
					player.save
					player.update_attributes(:game => game)
					player.update_attributes(:team => team)
				end
			end

			sections.css("scores").first do |s| 					# there should only be one 'scores' section
				scores = s.children
				
				scores.css('score').each do |score|
					score_param = {
						:qtr => score["qtr"],
						:clock => score["clock"],
						:type => score["type"],
						:how => score["how"],
						:yds => score["yds"],
						:scorer => score["scorer"],
						:passer => score["passer"],
						:patby => score["patby"],
						:pattype => score["pattype"],
						:patres => score["patres"],
						:plays => score["plays"].to_i,
						:drive => score["drive"].to_i,
						:top => score["top"],
						:vscore => score["vscore"],
						:hscore => score["hscore"]
					}	
					score = Score.new(score_param)
					score.save
					score.update_attributes(:game => game)
					score.update_attributes(:team => team)
				end
			end

			# sections.css('team').first do |t|
			# 	ls = t.children
			# 	linescore_param = {
			# 		:prds => ls['prds'].to_i,
			# 		:score => ls['score'].to_i
			# 	}
			# 	linescore = Linescore.new(linescore_param) 
			# 	linescore.save
			# 	linescore.update_attributes(:game => game)
			# 	game.update_attributes(:linescore =>linescore)
			# end

		end
	end
end
				