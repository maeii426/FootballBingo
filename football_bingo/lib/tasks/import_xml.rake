namespace :import do
	desc 'import game from XML'
	task :getxmlgame => :environment do
		require 'nokogiri'
		require 'date'
		doc = Nokogiri::XML(open("./XML/tam.xml"))
		doc.css('fbgame').each do |node|
			sections = node.children
			hometeam = sections.css('venue').first['homeid']
			visteam = sections.css('venue').first['visid']
			game_param = {
				:date => Date.strptime(sections.css('venue').first['date'], '%m/%d/%Y'),
				:source => node['source'],
				:version => node['version'],
				:generated => node['generated'],
				:hometeam => hometeam,
				:visteam => visteam,
				:game_name => "#{hometeam} vs #{visteam}"
			}

			game = Game.new(game_param)
			game.save ? puts "game imported!" : puts "game failed!"
  			game.update(state: 'ongoing')

			sections.css('venue').each do |v|		# there should only be one venue

				venue_param = {
					:gameid => v['gameid'],
					:date => Date.strptime(v['date'], '%m/%d/%Y'),
					:attend => v['attend'].to_i,
					:location => v['location']				
				}

				venue = Venue.new(venue_param) 				
				venue.save ? puts "venue imported!" : puts "venue failed!"
				venue.update_attributes(:game => game)
			end

			sections.css('team').each do |t|					# there sould be two team sections
				team_param = {
					:name => t['name'],
					:nameid => t['id']
				}
				team = Team.new(team_param) 
				team.save ? puts "team imported!" : puts "team failed!"
				
				team_stuff = t.children
				team_stuff.css('linescore').each do |ls|		# there should only be one per team!
					linescore_param = {
						:prds => ls['prds'].to_i,
						:score => ls['score'].to_i
					}
					linescore = Linescore.new(linescore_param) 			
					linescore.save ? puts "linescore imported!" : puts "linescore failed!"

					game.linescores << linescore
					team.linescores << linescore
				
					ttt = ls.children
					ttt.css('lineprd').each do |lp|
						#UPDATE linescoreconditions to migration of lineprds for timestamps on the scores :)
					end
				end

				team_stuff.css('player').each do |py|
					player_param = {
						:name => py['name'],
						:shortname => py['shortname'],
						:class_attr => py['class']
					}	
					player = Player.new(player_param)
					player.save ? puts "player imported!" : puts "player failed!"

					game.players << player
					team.players << player
				end
				
				team_stuff.css('totals').each do |tot|			# there should only be one per team!
					total_param = {
						:qtr => "all",
						:totoff_plays => tot["totoff_plays"].to_i,
						:totoff_yards => tot["totoff_yards"].to_i,
						:totoff_avg => tot["totoff_avg"].to_f
					}
					total = Total.new(total_param) 
					total.save ? puts "total imported!" : puts "total failed!"
					game.totals << total
					team.totals << total
					
					tot_misc = tot.children
					
					# Get all the tags: tags = ['firstdowns', ...]
					tags = []
					tot_misc.each do |t|
						tag = t.name.split(/\n+/)
						tag.delete_if{|e| e == "text"}
						tags += tag
					end

					tags.each do |tag|
						tot_misc.css(tag).each do |t|
							t_attrs = t.attributes
							t_attrs.each do |atr_name, node_attr|
								# col_name = 'firstdowns_no', 'firstdowns_rush'...
								col_name = tag + '_' + atr_name
								# current_value = t[atr_name].to_i
								totalcon = Totalcondition.new({:value => t[atr_name].to_i})
								totalcon.save ? puts "#{col_name} imported!" : puts "#{col_name} failed!"

								# find the associated translation
								trans = Translation.where(:tag => col_name).first
								if trans.nil?
									trans = Translation.create!({:tag => col_name, :words => col_name})
									puts "#{col_name} saved and need to be updated in translation!"
								end

								# Generate some chips with some prob based on the current states
								probs = [0.85, 0.65, 0.45, 0.25, 0.05]
								$t = 0
								probs.each do |i|
									$t += 2
									chip = trans.chips.create!(:argument => '>', :value => (t[atr_name].to_i+$t), :probablity => i)	
									game.chips << chip
								end
								trans.totalconditions << totalcon
								total.totalconditions << totalcon
							end
						end
					end
				end
			end

			sections.css("scores").each do |s| 					# there should only be one 'scores' section
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
						:vscore => score["vscore"].to_i,
						:hscore => score["hscore"].to_i
					}	
					score_ = Score.new(score_param)
					score_.save ? puts "score imported!" : puts "score failed!"

					team = Team.where(:name => score["team"]).first
					team.scores << score_
					game.scores << score_
				end
			end

			sections.css("fgas").each do |f| 			# there should only be one 'fgas' section
				fgas = f.children
				fgas.css('fga').each do |fga|
					result = (fga["result"] == "good") 

					fga_param = {
						:kicker => fga["kicker"],
						:qtr => fga["qtr"],
						:clock => fga["clock"],
						:distance => fga["distance"].to_i,
						:result => result
					}
					fga = Fga.new(fga_param)
					fga.save ? puts "fga imported!" : puts "fga failed!"
					game.fgas << fga
					team = Team.where(:name => fga["team"]).first
					team.fgas << fga
				end
			end

			sections.css("drives").each do |d| 			# there should only be one 'fgas' section
				drives = d.children
				drives.css('drive').each do |dr|

					drive_param = {
						:start => dr["start"],
						:end => dr["end"],
						:plays => dr["plays"].to_i,
						:yards => dr["yards"].to_i,
						:top => dr["top"],
						:start_how => dr["start_how"],
						:start_qtr => dr["start_qtr"],
						:start_time => dr["start_time"],
						:start_spot => dr["start_spot"],
						:end_how => dr["end_how"],
						:end_qtr => dr["end_qtr"],
						:end_time => dr["end_time"],
						:end_spot => dr["end_spot"]
					}
					drive = Drife.new(drive_param)
					drive.save ? puts "drive imported!" : puts "drive failed!"
					game.drives << drive
					team = Team.where(:name => dr["team"]).first
					team.drives << drive
				end
			end
		end
	end
end
				