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
				:hometeam => sections.css('venue').first['homeid'],
				:visteam => sections.css('venue').first['visid'],
				# :gamename => :hometeam_id + " vs " + :visteam_id
			}

			game = Game.new(game_param)
			if game.save
				puts "game imported!"
			else
				puts "game failed!"
			end

			sections.css('venue').each do |v|		# there should only be one venue

				venue_param = {
					:gameid => v['gameid'],
					:date => Date.strptime(v['date'], '%m/%d/%Y'),
					:attend => v['attend'].to_i,
					:location => v['location']				
				}

				venue = Venue.new(venue_param) 				
				if venue.save
					puts "venue imported!"
				else
					puts "venue failed!"
				end
				venue.update_attributes(:game => game)
				game.update_attributes(:venue => venue)
			end

			sections.css('team').each do |t|					# there sould be two team sections
				team_param = {
					:name => t['name'],
					:nameid => t['id']
				}
				team = Team.new(team_param) 
				if team.save
					puts "team imported!"
				else
					puts "team failed!"
				end
				
				team_stuff = t.children
				team_stuff.css('linescore').each do |ls|		# there should only be one per team!
					linescore_param = {
						:prds => ls['prds'].to_i,
						:score => ls['score'].to_i
					}
					linescore = Linescore.new(linescore_param) 
					
					if linescore.save
						puts "linescore imported!"
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
				
				team_stuff.css('totals').each do |tot|			# there should only be one per team!
					total_param = {
						:qtr => "all",
						:totoff_plays => tot["totoff_plays"].to_i,
						:totoff_yards => tot["totoff_yards"].to_i,
						:totoff_avg => tot["totoff_avg"].to_f
					}
					total = Total.new(total_param) 
					if total.save
						puts "total imported!"
					else
						puts "total failed!"
					end
					total.update_attributes(:game => game)
					total.update_attributes(:team => team)
					
					tot_misc = tot.children

					tot_misc.css('firstdowns').each do |fd|

						fd_param = {
							:no => fd['no'].to_i,
							:rush => fd['rush'].to_i,
							:pass => fd['pass'].to_i,
							:penalty => fd['penalty'].to_i
						}

						firstdown = Firstdown.new(fd_param)
						if firstdown.save
							puts "firstdown imported!"
						else
							puts "firstdown failed!"
						end
						firstdown.update_attributes(:total => total)
			
					end

					tot_misc.css('penalties').each do |pt|

						p_param = {
							:no => pt['no'].to_i,
							:yds => pt['yds'].to_i
						}

						penalty = Penalty.new(p_param)
						if penalty.save
							puts "penalty imported!"
						else
							puts "penalty failed!"
						end
						penalty.update_attributes(:total => total)
			
					end

					tot_misc.css('conversions').each do |cv|

						cv_param = {
							:thirdconv => cv['thirdconv'].to_i,
							:thirdatt => cv['thirdatt'].to_i,
							:fourthconv => cv['fourthconv'].to_i,
							:fourthatt => cv['fourthatt'].to_i
						}

						conversion = Conversion.new(cv_param)
						if conversion.save
							puts "conversion imported!"
						else
							puts "conversion failed!"
						end
						conversion.update_attributes(:total => total)
			
					end


					tot_misc.css('fumbles').each do |f|
						f_param = {
							:no => f['no'].to_i,
							:lost => f['lost'].to_i
						}
						fumble = Fumble.new(f_param)
						if fumble.save
							puts "fumble imported!"
						else
							puts "fumble failed!"
						end
						fumble.update_attributes(:total => total)
					end

					tot_misc.css('redzone').each do |f|
						f_param = {
							:att => f['att'].to_i,
							:scores => f['scores'].to_i,
							:points => f['points'].to_i,
							:tdrush => f['tdrush'].to_i,
							:tdpass => f['tdpass'].to_i,
							:fgmade => f['fgmade'].to_i,
							:endfga => f['endfga'].to_i,
							:enddowns => f['enddowns'].to_i,
							:endint => f['endint'].to_i,
							:endfumb => f['endfumb'].to_i,
							:endhalf => f['endhalf'].to_i,
							:endgame => f['endgame'].to_i
						}
						redzone = Redzone.new(f_param)
						if redzone.save
							puts "redzone imported!"
						else
							puts "redzone failed!"
						end
						redzone.update_attributes(:total => total)
					end

					tot_misc.css('rush').each do |f|
						f_param = {
							:att => f['att'].to_i,
							:yds => f['yds'].to_i,
							:gain => f['gain'].to_i,
							:loss => f['loss'].to_i,
							:td => f['td'].to_i,
							:long => f['long'].to_i
						}
						rush = Rush.new(f_param)
						if rush.save
							puts "rush imported!"
						else
							puts "rush failed!"
						end
						rush.update_attributes(:total => total)
					end

					tot_misc.css('pass').each do |f|
						f_param = {
							:comp => f['comp'].to_i,
							:att => f['att'].to_i,
							:int => f['int'].to_i,
							:yds => f['yds'].to_i,
							:td => f['td'].to_i,
							:long => f['long'].to_i,
							:sacks => f['sacks'].to_i,
							:sackyds => f['sackyds'].to_i
						}
						pass = Pass.new(f_param)
						if pass.save
							puts "pass imported!"
						else
							puts "pass failed!"
						end
						pass.update_attributes(:total => total)
					end

					tot_misc.css('rcv').each do |f|
						f_param = {
							:no => f['no'].to_i,
							:yds => f['yds'].to_i,
							:td => f['td'].to_i,
							:long => f['long'].to_i
						}
						rcv = Rcv.new(f_param)
						if rcv.save
							puts "rcv imported!"
						else
							puts "rcv failed!"
						end
						rcv.update_attributes(:total => total)
					end

					tot_misc.css('punt').each do |f|
						f_param = {
							:no => f['no'].to_i,
							:yds => f['yds'].to_i,
							:long => f['long'].to_i,
							:blkd => f['blkd'].to_i,
							:tb => f['tb'].to_i,
							:fc => f['fc'].to_i,
							:plus50 => f['plus50'].to_i,
							:inside20 => f['inside20'].to_i,
							:avg => f['avg'].to_f
						}
						punt = Punt.new(f_param)
						if punt.save
							puts "punt imported!"
						else
							puts "punt failed!"
						end
						punt.update_attributes(:total => total)
					end

					tot_misc.css('ko').each do |f|
						f_param = {
							:no => f['no'].to_i,
							:yds => f['yds'].to_i,
							:ob => f['ob'].to_i,
							:tb => f['tb'].to_i,
							:fcyds => f['fcyds'].to_i
						}
						ko = Ko.new(f_param)
						if ko.save
							puts "ko imported!"
						else
							puts "ko failed!"
						end
						ko.update_attributes(:total => total)
					end

					tot_misc.css('fg').each do |f|
						f_param = {
							:made => f['made'].to_i,
							:att => f['att'].to_i,
							:long => f['long'].to_i,
							:blkd => f['blkd'].to_i
						}
						fg = Fg.new(f_param)
						if fg.save
							puts "fg imported!"
						else
							puts "fg failed!"
						end
						fg.update_attributes(:total => total)
					end

					tot_misc.css('pat').each do |f|
						f_param = {
							:kickatt => f['kickatt'].to_i,
							:kickmade => f['kickmade'].to_i,
							:passatt => f['passatt'].to_i,
							:passmade => f['passmade'].to_i,
							:rcvatt => f['rcvatt'].to_i,
							:rcvmade => f['rcvmade'].to_i
						}
						pat = Pat.new(f_param)
						if pat.save
							puts "pat imported!"
						else
							puts "pat failed!"
						end
						pat.update_attributes(:total => total)
					end

					tot_misc.css('defense').each do |f|
						f_param = {
							:tackua => f['tackua'].to_i,
							:tacka => f['tacka'].to_i,
							:tot_tack => f['tot_tack'].to_i,
							:tflua => f['tflua'].to_i,
							:tfla => f['tfla'].to_i,
							:tflyds => f['tflyds'].to_i,
							:sacks => f['sacks'].to_i,
							:sackyds => f['sackyds'].to_i,
							:brup => f['brup'].to_i,
							:qbh => f['qbh'].to_i,
							:ff => f['ff'].to_i,
							:fr => f['fr'].to_i,
							:fryds => f['fryds'].to_i
						}
						defense = Defense.new(f_param)
						if defense.save
							puts "defense imported!"
						else
							puts "defense failed!"
						end
						defense.update_attributes(:total => total)
					end


					tot_misc.css('kr').each do |f|
						f_param = {
							:no => f['no'].to_i,
							:yds => f['yds'].to_i,
							:long => f['long'].to_i,
							:td => f['td'].to_i
						}
						kr = Kr.new(f_param)
						if kr.save
							puts "kr imported!"
						else
							puts "kr failed!"
						end
						kr.update_attributes(:total => total)
					end

					tot_misc.css('pr').each do |f|
						f_param = {
							:no => f['no'].to_i,
							:yds => f['yds'].to_i,
							:long => f['long'].to_i,
							:td => f['td'].to_i
						}
						pr = Pr.new(f_param)
						if pr.save
							puts "pr imported!"
						else
							puts "pr failed!"
						end
						pr.update_attributes(:total => total)
					end

					tot_misc.css('fr').each do |f|
						f_param = {
							:no => f['no'].to_i,
							:yds => f['yds'].to_i,
							:long => f['long'].to_i,
							:td => f['td'].to_i
						}
						fr = Fr.new(f_param)
						if fr.save
							puts "fr imported!"
						else
							puts "fr failed!"
						end
						fr.update_attributes(:total => total)
					end

					#loop through the different css values of totals and update totalconditions
					#   OR update the migrations to account for each of the conditions - and add translations as necessary
				end
				
				team_stuff.css('player').each do |py|
					player_param = {
						:name => py['name'],
						:shortname => py['shortname'],
						:class_attr => py['class']
					}	
					player = Player.new(player_param)
					if player.save
						puts "player imported!"
					else
						puts "player failed!"
					end
					player.update_attributes(:game => game)
					player.update_attributes(:team => team)
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
						puts "score imported!"
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
						puts "fga imported!"
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
						puts "drive imported!"
					else
						puts "drive failed!"
					end

					drive.update_attributes(:game => game)
					team = Team.where(:name => dr["team"]).first
					drive.update_attributes(:team => team)

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
				