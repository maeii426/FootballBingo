module ImportXML

def get_xml_game(filepath)
    require 'nokogiri'
    require 'date'
	  doc = Nokogiri::XML(open(filepath))
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
			:game_name => sections.css('venue').first['gameid']
		}

        # games = Game.where(game_param)
        games = Game.where({:game_name => sections.css('venue').first['gameid']})

        if games.length != 0
            puts "exising game found"
            if games.length != 1
                puts "SERIOUS PROBLEMS"
            end
            game = games.first
            game.update(game_param)
        else
            puts "creating new game"
            game = Game.new(game_param)
            game.save		
            #game = Game.first_or_create(game_param)
			if game.save
				#puts "game imported!"
			else
				puts "game failed!"
			end
        end

		game = Game.where(game_param).first
		end_time = sections.css('venue').first['date']
		if end_time.nil? || end_time.empty?
  		    game.update(state: 'ongoing')
  		else
  		    game.update(state: 'finished')
  		end

  		### To Delete
  		### Import as ongoing to test
  		game.update(state: 'ongoing')


		sections.css('venue').each do |v|		# there should only be one venue

			venue_param = {
				:gameid => v['gameid'],
				:date => Date.strptime(v['date'], '%m/%d/%Y'),
				:attend => v['attend'].to_i,
				:location => v['location']
			}

			venues = Venue.where(venue_param)
    		if venues.length != 0
                puts "exising venue found"
                if venues.length != 1
                    puts "SERIOUS PROBLEMS"
                end
                venue = venues.first
                venue.update(venue_param)
            else
                puts "creating new venue"
                venue = Venue.new(venue_param)
            end

			if venue.save
				#puts "venue imported!"
			else
				puts "venue failed!"
			end
			venue.update_attributes(:game => game)
			#game.update_attributes(:venue => venue)
		end

		sections.css('team').each do |t|					# there sould be two team sections
			team_param = {
				:name => t['name'],
				:nameid => t['id']
			}
			team = Team.new(team_param)
			if team.save
				#puts "team imported!"
			else
				puts "team failed!"
				team = Team.where(team_param).first
				if !team.nil?
					puts "associated with existing team!"
				end
			end

			team_stuff = t.children
			team_stuff.css('linescore').each do |ls|		# there should only be one per team!
				linescore_param = {
					:prds => ls['prds'].to_i,
					:score => ls['score'].to_i
				}
				linescore = Linescore.new(linescore_param)

				if linescore.save
					#puts "linescore imported!"
				else
					puts "linescore failed!"
				end

				linescore.update_attributes(:game => game)
				linescore.update_attributes(:team => team)
				#game.update_attributes(:linescore =>linescore)

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
				if player.save
					#puts "player imported!"
				else
					puts "player failed!"
				end
				player.update_attributes(:game => game)
				player.update_attributes(:team => team)
			end

			team_stuff.css('totals').each do |tot|			# there should only be one per team!
				total_param = {
					:qtr => "all",
					:totoff_plays => tot["totoff_plays"].to_i,
					:totoff_yards => tot["totoff_yards"].to_i,
					:totoff_avg => tot["totoff_avg"].to_f
				}
				total = Total.new(total_param)
				if total.save
					#puts "total imported!"
				else
					puts "total failed!"
				end
				total.update_attributes(:game => game)
				total.update_attributes(:team => team)

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
							if totalcon.save
								#puts col_name+" imported!"
							else
								puts col_name+" failed!"
							end

							# find the associated translation
							trans = Translation.where(:tag => col_name).first
							if trans.nil?
								trans = Translation.new({:tag => col_name, :words => col_name})
								if trans.save
									puts col_name + " saved and needs to be updated in translation! "
								else
									puts col_name + " translation not saved! "
								end
							end

							# Generate some chips with some prob based on the current states
							probs = [0.85, 0.65, 0.45, 0.25, 0.05]
							$t = 0
							for i in probs do
								$t += 2
								chip = trans.chips.create!(:argument => '>', :value => (t[atr_name].to_i+$t), :probablity => i)
								chip.set_level
								chip.update_attributes(:game => game)
							end

							totalcon.update_attributes(:total => total)
							totalcon.update_attributes(:translation => trans)
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
				if score_.save
					#puts "score imported!"
				else
					puts "score failed!"
				end
				score_.update_attributes(:game => game)
				team = Team.where(:name => score["team"]).first
				score_.update_attributes(:team => team)
			end
		end

		sections.css("fgas").each do |f| 			# there should only be one 'fgas' section
			fgas = f.children
			fgas.css('fga').each do |fga|
				if fga["result"] == "good"
					result = true
				else
					result = false
				end

				fga_param = {
					:kicker => fga["kicker"],
					:qtr => fga["qtr"],
					:clock => fga["clock"],
					:distance => fga["distance"].to_i,
					:result => result
				}
				fga = Fga.new(fga_param)

				if fga.save
					#puts "fga imported!"
				else
					puts "fga failed!"
				end

				fga.update_attributes(:game => game)
				team = Team.where(:name => fga["team"]).first
				fga.update_attributes(:team => team)

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

				if drive.save
					#puts "drive imported!"
				else
					puts "drive failed!"
				end

				drive.update_attributes(:game => game)
				team = Team.where(:name => dr["team"]).first
				drive.update_attributes(:team => team)

			end
		end
    puts("ye!")
	end
end


def update_xml_game(filepath)
    require 'nokogiri'
    require 'date'
	  doc = Nokogiri::XML(open(filepath))
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
			:game_name => sections.css('venue').first['gameid']
		}

        # games = Game.where(game_param)
        games = Game.where({:game_name => sections.css('venue').first['gameid']})

        if games.length != 0
            puts "exising game found"
            if games.length != 1
                puts "SERIOUS PROBLEMS"
            end
            game = games.first
            game.update(game_param)
        else
            puts "Unable to find existing game!"
        end

		game = Game.where(game_param).first
		end_time = sections.css('venue').first['date']
		if end_time.nil? || end_time.empty?
  		    game.update(state: 'ongoing')
  		else
  		    game.update(state: 'finished')
  		end
  		game.update(state: 'ongoing')

		sections.css('team').each do |t|					# there sould be two team sections
			team_param = {
				:name => t['name'],
				:nameid => t['id']
			}		
			
			team = Team.where(team_param).first
			if !team.nil?
				puts "associated with existing team!"
			else 
				puts "no associated team!"
			end

			team_stuff = t.children
			team_stuff.css('linescore').each do |ls|		# there should only be one per team!
				linescore_param = {
					:prds => ls['prds'].to_i,
					:score => ls['score'].to_i
				}

				linescore = Linescore.where(:game=>game, :team=>team).first

				if linescore.nil?		
					puts "update linescore failed!"
				end
			end

			team_stuff.css('totals').each do |tot|			# there should only be one per team!
				total_param = {
					:qtr => "all",
					:totoff_plays => tot["totoff_plays"].to_i,
					:totoff_yards => tot["totoff_yards"].to_i,
					:totoff_avg => tot["totoff_avg"].to_f
				}
				total = Total.where(:game=>game, :team=>team).first
				if total.nil?
					puts "update total failed!"
				end
			
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

							# find the associated translation
							trans = Translation.where(:tag => col_name).first
							if trans.nil?
								trans = Translation.new({:tag => col_name, :words => col_name})
								if trans.save
									puts col_name + " saved and needs to be updated in translation! "
								else
									puts col_name + " translation not saved! "
								end
							end

							totalcon = Totalcondition.where(:total => total, :translation =>trans).first
							 
							# totalcon = Totalcondition.new({:value => t[atr_name].to_i})
							if totalcon.nil?
								#puts col_name+" imported!"
								puts "update " + col_name +" failed!"
							else
								prev_value = totalcon.value
								totalcon.update_attributes(:value => t[atr_name].to_i)
							end

							# Don't generate chips here
							# Generate some chips with some prob based on the current states:  
							# probs = [0.85, 0.65, 0.45, 0.25, 0.05]
							# $t = 0
							# for i in probs do
							# 	$t += 2
							# 	chip = trans.chips.create!(:argument => '>', :value => (t[atr_name].to_i+$t), :probablity => i)
							# 	chip.set_level
							# 	chip.update_attributes(:game => game)
							# end
						end
					end
				end
			end
		end

		# sections.css("scores").each do |s| 					# there should only be one 'scores' section
		# 	scores = s.children

		# 	scores.css('score').each do |score|
		# 		score_param = {
		# 			:qtr => score["qtr"],
		# 			:clock => score["clock"],
		# 			:type => score["type"],
		# 			:how => score["how"],
		# 			:yds => score["yds"],
		# 			:scorer => score["scorer"],
		# 			:passer => score["passer"],
		# 			:patby => score["patby"],
		# 			:pattype => score["pattype"],
		# 			:patres => score["patres"],
		# 			:plays => score["plays"].to_i,
		# 			:drive => score["drive"].to_i,
		# 			:top => score["top"],
		# 			:vscore => score["vscore"].to_i,
		# 			:hscore => score["hscore"].to_i
		# 		}
		# 		score_ = Score.new(score_param)
		# 		if score_.save
		# 			#puts "score imported!"
		# 		else
		# 			puts "score failed!"
		# 		end
		# 		score_.update_attributes(:game => game)
		# 		team = Team.where(:name => score["team"]).first
		# 		score_.update_attributes(:team => team)
		# 	end
		# end

		# sections.css("fgas").each do |f| 			# there should only be one 'fgas' section
		# 	fgas = f.children
		# 	fgas.css('fga').each do |fga|
		# 		if fga["result"] == "good"
		# 			result = true
		# 		else
		# 			result = false
		# 		end

		# 		fga_param = {
		# 			:kicker => fga["kicker"],
		# 			:qtr => fga["qtr"],
		# 			:clock => fga["clock"],
		# 			:distance => fga["distance"].to_i,
		# 			:result => result
		# 		}
		# 		fga = Fga.new(fga_param)

		# 		if fga.save
		# 			#puts "fga imported!"
		# 		else
		# 			puts "fga failed!"
		# 		end

		# 		fga.update_attributes(:game => game)
		# 		team = Team.where(:name => fga["team"]).first
		# 		fga.update_attributes(:team => team)

		# 	end
		# end

		# sections.css("drives").each do |d| 			# there should only be one 'fgas' section
		# 	drives = d.children
		# 	drives.css('drive').each do |dr|

		# 		drive_param = {
		# 			:start => dr["start"],
		# 			:end => dr["end"],
		# 			:plays => dr["plays"].to_i,
		# 			:yards => dr["yards"].to_i,
		# 			:top => dr["top"],
		# 			:start_how => dr["start_how"],
		# 			:start_qtr => dr["start_qtr"],
		# 			:start_time => dr["start_time"],
		# 			:start_spot => dr["start_spot"],
		# 			:end_how => dr["end_how"],
		# 			:end_qtr => dr["end_qtr"],
		# 			:end_time => dr["end_time"],
		# 			:end_spot => dr["end_spot"]
		# 		}
		# 		drive = Drife.new(drive_param)

		# 		if drive.save
		# 			#puts "drive imported!"
		# 		else
		# 			puts "drive failed!"
		# 		end

		# 		drive.update_attributes(:game => game)
		# 		team = Team.where(:name => dr["team"]).first
		# 		drive.update_attributes(:team => team)

		# 	end
		# end
    puts("updated!")
	end
end


end
