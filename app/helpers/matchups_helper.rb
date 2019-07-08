module MatchupsHelper

	def define_home_away

		Team.all.each do |t|

			if @matchup.fav == t.matchup_abbr

				if @matchup.fav_field == "home"

					@home_team = t
					@home_spread = @matchup.fav_ml


				else

					if @matchup.fav_field == "away"

						@road_team = t
						@road_spread = @matchup.fav_ml

					end


				end


			end

			if @matchup.dog == t.matchup_abbr

				if @matchup.dog_field == "home"

					@home_team = t
					@home_spread = @matchup.dog_ml

				else

					@road_team = t
					@road_spread = @matchup.dog_ml


				end

			end

		end


	end

	def get_home_game_logs

		@home_team.mlb_game_logs.each do |m|

			@home_team_all_games.push(m)

			if m.home.downcase == "true"

				@home_team_home_games.push(m)

			end

			if m.opp == @road_team.matchup_abbr

				@home_vs_opp.push(m)

			end

			if m.team_starting_pitcher == @matchup.home_pitcher

				@home_with_pitcher.push(m)


			end

			if m.opp_starting_pitcher == @matchup.away_pitcher

				@home_vs_pitcher.push(m)


			end

			@home_team.mlb_game_logs.last(10).each do |mlb|

				if m == mlb

					@home_last_ten.push(m)

				end


			end


		end

	end

	def get_away_game_logs

		@road_team.mlb_game_logs.each do |m|

			@road_team_all_games.push(m)

			if m.home.downcase == "false"

				@road_team_road_games.push(m)

			end

			if m.opp == @home_team.matchup_abbr

				@road_vs_opp.push(m)

			end

			if m.opp_starting_pitcher == @matchup.home_pitcher

				@road_vs_pitcher.push(m)


			end

			if m.team_starting_pitcher == @matchup.away_pitcher

				@road_with_pitcher.push(m)


			end

			@road_team.mlb_game_logs.last(10).each do |mlb|

				if m == mlb

					@road_last_ten.push(m)

				end


			end


		end
		

	end

	def compute_stats(array)

		@test
		@runs_per = 0

		@starter_pitches = 0
		@bullpen_pitches = 0
		@runs_for = 0
		@runs_against = 0
		@hits_for = 0
		@hits_against = 0
		@at_bats_for = 0
		@at_bats_against = 0
		@innings = 0
		@innings_game = 0
		@opp_starter_pitches = 0
		@opp_bullpen_pitches = 0
		@runs_by_bullpen = 0
		@runs_by_starter = 0
		@runs_by_opp_bullpen = 0
		@runs_by_opp_starter = 0
		@wins = 0
		@losses = 0

		array.each do |m|

			if m.spread_result.downcase == "win"

				@wins += 1

			elsif m.spread_result.downcase == "loss"

				@losses += 1

			end

			@starter_pitches += m.team_starter_pitches.to_i
			@bullpen_pitches += m.team_bullpen_picthes.to_i
			@runs_for += m.team_runs.to_i
			@runs_against += m.opp_runs.to_i
			@hits_for += m.team_hits.to_i
			@hits_against += m.opp_hits.to_i
			@at_bats_for += m.at_bats_for.to_i
			@at_bats_against += m.at_bats_against.to_i
			@innings += m.innings.to_i
			@innings_game += m.innings.to_i
			@opp_starter_pitches += m.opp_starter_pitches.to_i
			@opp_bullpen_pitches += m.opp_bullpen_picthes.to_i
			@runs_by_bullpen += m.runs_by_team_bullpen.to_i
			@runs_by_starter += m.runs_by_team_starter.to_i
			@runs_by_opp_bullpen += m.runs_by_opp_bullpen.to_i
			@runs_by_opp_starter += m.runs_by_opp_starter.to_i

			@runs_per += m.innings.to_i 

		end


		runs_per_game = ((@runs_for.to_f / @runs_per.to_f) * 9).round(2)
		runs_against = ((@runs_against.to_f / @runs_per.to_f) * 9).round(2)
		hits_per_game = ((@hits_for.to_i / @runs_per.to_f).round(2) * 9).round(2)
		hits_against_per_game = ((@hits_against.to_f / @runs_per.to_f) * 9).round(2)
		at_bats_per_game = ((@at_bats_for.to_f / @innings.to_f) * 9).round(2)
		at_bats_against_per_game = ((@at_bats_against.to_f / @innings.to_f) * 9).round(2)
		at_bats_per_run = (1.0 / (@runs_for.to_f / @at_bats_for.to_f )).round(2)
		run_diff = (@runs_for - @runs_against)
		hits_needed_per_run = (@hits_for.to_f / @runs_for.to_f).round(2)
		innings_per_run = (@innings.to_f / @runs_for.to_f).round(2)
		pitches_seen_per_game = (((@opp_starter_pitches.to_f + @opp_bullpen_pitches.to_f) / @innings.to_f) * 9).round(2)
		runs_per_pitch_by_opp = (1.0 / (@runs_for.to_f / (@opp_starter_pitches.to_f + @opp_bullpen_pitches.to_f))).round(3)
		at_bats_per_nine = ((@at_bats_for.to_f/ @innings.to_f) * 9).round(2)
		hits_per_nine = (@hits_for.to_f / @innings.to_f).round(2) * 9

		runs_against_per_at_bat = (1.0 / (@runs_against.to_f / @at_bats_against.to_f)).round(2)
		opp_hits_needed_per_run = (@hits_against.to_f / @runs_against.to_f).round(2)
		opp_runs_per_inning = (@runs_against.to_f / @innings.to_f).round(2)
		opp_at_bats_per_nine = ((@at_bats_against.to_f/ @innings.to_f).round(2) * 9).round(2)
		opp_hits_per_nine = ((@hits_against.to_f / @innings.to_f).round(2) * 9).round(2)

		pitches_thrown_per_game = (((@starter_pitches.to_f + @bullpen_pitches.to_f) / @runs_per.to_f) * 9).round(2)

		combined_pitches = @starter_pitches + @bullpen_pitches
		
		opp_runs_per_pitch = (pitches_thrown_per_game.to_f / @runs_against.to_f).round(2)

	
		@test = (combined_pitches / @runs_against.to_f).round(2)

		opp_runs_per_pitch = @test
		

		starter_freq = ((@starter_pitches.to_f / (@starter_pitches + @bullpen_pitches).to_f) * 100).round(2)
		starter_freq_to_string = starter_freq.to_s + "%"
		bullpen_freq = (100.0 - starter_freq).round(2)
		bullpen_freq_to_string = bullpen_freq.to_s + "%"
		bullpen_rpp = (1.0 / (@runs_by_bullpen.to_f / @bullpen_pitches.to_f)).round(3)
		starter_rpp = (1.0 / (@runs_by_starter.to_f / @starter_pitches.to_f)).round(3)

		starter_pitch_avg = (@starter_pitches.to_f / array.length).round(2)
		bullpen_pitch_avg = (@bullpen_pitches.to_f / array.length).round(2)

		starter_run_avg = (@runs_by_starter.to_f / array.length).round(2)
		bullpen_run_avg = (@runs_by_bullpen.to_f / array.length).round(2)

		opp_bullpen_rpp = (1.0 / (@runs_by_opp_bullpen.to_f / @opp_bullpen_pitches.to_f)).round(3)
		opp_starter_rpp = (1.0 / (@runs_by_opp_starter.to_f / @opp_starter_pitches.to_f)).round(3)

		opp_starter_freq = ((@opp_starter_pitches.to_f / (@opp_starter_pitches + @opp_bullpen_pitches).to_f) * 100).round(2)
		opp_bullpen_freq = (100.00 - opp_starter_freq).round(2)
		opp_starter_freq_to_s = opp_starter_freq.to_s + "%"
		opp_bullpen_freq_to_s = opp_bullpen_freq.to_s + "%"

		team_record = @wins.to_s + " " + "-" + " " + @losses.to_s


		good_at_bats_per_run = (@at_bats_for.to_f - (@innings * 3) / @runs_for.to_f).round(2)

		opp_good_at_bats_per_run = (@at_bats_against.to_f - (@innings * 3) / @runs_against.to_f).round(2)

		if array == @home_team_all_games

			home_team_all = Hash.new


			home_team_all[:games] = array.length
			home_team_all[:record] = team_record
			home_team_all[:run_diff] = run_diff
			home_team_all[:runs_per_game] = runs_per_game
			home_team_all[:runs_against_per_game] = runs_against
			home_team_all[:hits_per_game] = hits_per_game.round(2)
			home_team_all[:hits_against_per_game] = hits_against_per_game
			home_team_all[:at_bats_per_game] = at_bats_per_game
			home_team_all[:at_bats_against_per_game] = at_bats_against_per_game
			home_team_all[:at_bats_per_run] = at_bats_per_run
			home_team_all[:hits_needed_per_run] = hits_needed_per_run
			home_team_all[:innings_per_run] = innings_per_run
			home_team_all[:pitches_seen_per_game] = pitches_seen_per_game
			home_team_all[:runs_per_pitch_by_opp] = runs_per_pitch_by_opp
			home_team_all[:at_bats_per_nine] = at_bats_per_nine
			home_team_all[:hits_per_nine] = hits_per_nine
			home_team_all[:pitches_thrown_per_game] = pitches_thrown_per_game
			home_team_all[:opp_runs_per_pitch] = opp_runs_per_pitch
			home_team_all[:bullpen_rpp] = bullpen_rpp
			home_team_all[:starter_rpp] = starter_rpp

			@home_all_stats = home_team_all
			@home_all_stats[:opp_runs_per_pitch] = home_team_all[:opp_runs_per_pitch]
			

		end

		if array == @home_with_pitcher

			home_team_with_pitcher = Hash.new

			home_team_with_pitcher[:games] = array.length
			home_team_with_pitcher[:record] = team_record
			home_team_with_pitcher[:run_diff] = run_diff
			home_team_with_pitcher[:starter_pitch_avg] = starter_pitch_avg
			home_team_with_pitcher[:bullpen_pitch_avg] = bullpen_pitch_avg
			home_team_with_pitcher[:at_bats_against_per_game] = opp_at_bats_per_nine
			home_team_with_pitcher[:hits_against_per_game] = hits_against_per_game
			home_team_with_pitcher[:runs_against_per_game] = runs_against
			home_team_with_pitcher[:starter_run_avg] = starter_run_avg
			home_team_with_pitcher[:bullpen_run_avg] = bullpen_run_avg
			home_team_with_pitcher[:bullpen_rpp] = bullpen_rpp
			home_team_with_pitcher[:starter_rpp] = starter_rpp
			home_team_with_pitcher[:opp_runs_per_pitch] = opp_runs_per_pitch
			home_team_with_pitcher[:innings_per_run] = innings_per_run
			home_team_with_pitcher[:pitches_thrown_per_game] = pitches_thrown_per_game
			

			home_team_with_pitcher[:runs_per_game] = runs_per_game
			home_team_with_pitcher[:opp_starter_freq] = opp_starter_freq_to_s
			home_team_with_pitcher[:opp_bullpen_freq] = opp_bullpen_freq_to_s
			
			@home_with_pitcher_stats = home_team_with_pitcher

		end


		if array == @home_team_home_games

			home_team_home = Hash.new

			home_team_home[:games] = array.length
			home_team_home[:record] = team_record
			home_team_home[:run_diff] = run_diff
			home_team_home[:runs_per_game] = runs_per_game
			home_team_home[:runs_against_per_game] = runs_against
			home_team_home[:hits_per_game] = hits_per_game
			home_team_home[:hits_against_per_game] = hits_against_per_game
			home_team_home[:at_bats_per_game] = at_bats_per_game
			home_team_home[:at_bats_against_per_game] = at_bats_against_per_game
			home_team_home[:at_bats_per_run] = at_bats_per_run
			home_team_home[:hits_needed_per_run] = hits_needed_per_run
			home_team_home[:innings_per_run] = innings_per_run
			home_team_home[:pitches_seen_per_game] = pitches_seen_per_game
			home_team_home[:runs_per_pitch_by_opp] = runs_per_pitch_by_opp
			home_team_home[:at_bats_per_nine] = at_bats_per_nine
			home_team_home[:hits_per_nine] = hits_per_nine
			home_team_home[:pitches_thrown_per_game] = pitches_thrown_per_game
			home_team_home[:opp_runs_per_pitch] = opp_runs_per_pitch
			home_team_home[:bullpen_rpp] = bullpen_rpp
			home_team_home[:starter_rpp] = starter_rpp

			@home_home_stats = home_team_home

		end

		if array == @home_vs_opp

			home_team_opp = Hash.new

			home_team_opp[:games] = array.length
			home_team_opp[:record] = team_record
			home_team_opp[:run_diff] = run_diff
			home_team_opp[:runs_per_game] = runs_per_game
			home_team_opp[:runs_against_per_game] = runs_against
			home_team_opp[:hits_per_game] = hits_per_game
			home_team_opp[:hits_against_per_game] = hits_against_per_game
			home_team_opp[:at_bats_per_game] = at_bats_per_game
			home_team_opp[:at_bats_per_run] = at_bats_per_run
			home_team_opp[:hits_needed_per_run] = hits_needed_per_run
			home_team_opp[:innings_per_run] = innings_per_run
			home_team_opp[:pitches_seen_per_game] = pitches_seen_per_game
			home_team_opp[:runs_per_pitch_by_opp] = runs_per_pitch_by_opp
			home_team_opp[:at_bats_per_nine] = at_bats_per_nine
			home_team_opp[:hits_per_nine] = hits_per_nine
			home_team_opp[:pitches_thrown_per_game] = pitches_thrown_per_game
			home_team_opp[:opp_runs_per_pitch] = opp_runs_per_pitch
			home_team_opp[:bullpen_rpp] = bullpen_rpp
			home_team_opp[:starter_rpp] = starter_rpp

			@home_opp_stats = home_team_opp

		end
		
		if array == @home_vs_pitcher

			home_team_pitcher = Hash.new

			home_team_pitcher[:games] = array.length
			home_team_pitcher[:record] = team_record
			home_team_pitcher[:run_diff] = run_diff
			home_team_pitcher[:runs_per_game] = runs_per_game
			home_team_pitcher[:hits_per_game] = hits_per_game
			home_team_pitcher[:at_bats_per_game] = at_bats_per_game
			home_team_pitcher[:at_bats_per_run] = at_bats_per_run
			home_team_pitcher[:hits_needed_per_run] = hits_needed_per_run
			home_team_pitcher[:innings_per_run] = innings_per_run
			home_team_pitcher[:pitches_seen_per_game] = pitches_seen_per_game
			home_team_pitcher[:runs_per_pitch_by_opp] = runs_per_pitch_by_opp
			home_team_pitcher[:at_bats_per_nine] = at_bats_per_nine
			home_team_pitcher[:hits_per_nine] = hits_per_nine
			home_team_pitcher[:opp_starter_freq] = opp_starter_freq_to_s
			home_team_pitcher[:opp_bullpen_freq] = opp_bullpen_freq_to_s
			home_team_pitcher[:opp_bullpen_rpp] = opp_bullpen_rpp
			home_team_pitcher[:opp_starter_rpp] = opp_starter_rpp

			@home_pitcher_stats = home_team_pitcher

		end
		
		if array == @home_last_ten

			home_team_last_ten = Hash.new

			home_team_last_ten[:record] = team_record
			home_team_last_ten[:run_diff] = run_diff
			home_team_last_ten[:runs_per_game] = runs_per_game
			home_team_last_ten[:runs_against_per_game] = runs_against
			home_team_last_ten[:hits_per_game] = hits_per_game
			home_team_last_ten[:hits_against_per_game] = hits_against_per_game
			home_team_last_ten[:at_bats_per_game] = at_bats_per_game
			home_team_last_ten[:at_bats_against_per_game] = at_bats_against_per_game
			home_team_last_ten[:at_bats_per_run] = at_bats_per_run
			home_team_last_ten[:hits_needed_per_run] = hits_needed_per_run
			home_team_last_ten[:innings_per_run] = innings_per_run
			home_team_last_ten[:pitches_seen_per_game] = pitches_seen_per_game
			home_team_last_ten[:runs_per_pitch_by_opp] = runs_per_pitch_by_opp
			home_team_last_ten[:at_bats_per_nine] = at_bats_per_nine
			home_team_last_ten[:hits_per_nine] = hits_per_nine
			home_team_last_ten[:pitches_thrown_per_game] = pitches_thrown_per_game
			home_team_last_ten[:opp_runs_per_pitch] = opp_runs_per_pitch
			home_team_last_ten[:starter_freq_to_string] = starter_freq_to_string
			home_team_last_ten[:bullpen_freq_to_string] = bullpen_freq_to_string
			home_team_last_ten[:bullpen_rpp] = bullpen_rpp
			home_team_last_ten[:starter_rpp] = starter_rpp

			@home_last_ten_stats = home_team_last_ten

		end
		
		if array == @road_team_all_games

			road_team_all = Hash.new

			road_team_all[:games] = array.length
			road_team_all[:record] = team_record
			road_team_all[:run_diff] = run_diff
			road_team_all[:runs_per_game] = runs_per_game
			road_team_all[:runs_against_per_game] = runs_against
			road_team_all[:hits_per_game] = hits_per_game
			road_team_all[:hits_against_per_game] = hits_against_per_game
			road_team_all[:at_bats_per_game] = at_bats_per_game
			road_team_all[:at_bats_against_per_game] = at_bats_against_per_game
			road_team_all[:at_bats_per_run] = at_bats_per_run
			road_team_all[:hits_needed_per_run] = hits_needed_per_run
			road_team_all[:innings_per_run] = innings_per_run
			road_team_all[:pitches_seen_per_game] = pitches_seen_per_game
			road_team_all[:runs_per_pitch_by_opp] = runs_per_pitch_by_opp
			road_team_all[:at_bats_per_nine] = at_bats_per_nine
			road_team_all[:hits_per_nine] = hits_per_nine
			road_team_all[:pitches_thrown_per_game] = pitches_thrown_per_game
			road_team_all[:opp_runs_per_pitch] = opp_runs_per_pitch
			road_team_all[:bullpen_rpp] = bullpen_rpp
			road_team_all[:starter_rpp] = starter_rpp

			@road_all_stats = road_team_all

		end
		
		if array == @road_team_road_games

			road_team_road = Hash.new

			road_team_road[:games] = array.length
			road_team_road[:record] = team_record
			road_team_road[:run_diff] = run_diff
			road_team_road[:runs_per_game] = runs_per_game
			road_team_road[:runs_against_per_game] = runs_against
			road_team_road[:hits_per_game] = hits_per_game
			road_team_road[:hits_against_per_game] = hits_against_per_game
			road_team_road[:at_bats_per_game] = at_bats_per_game
			road_team_road[:at_bats_against_per_game] = at_bats_against_per_game
			road_team_road[:at_bats_per_run] = at_bats_per_run
			road_team_road[:hits_needed_per_run] = hits_needed_per_run
			road_team_road[:innings_per_run] = innings_per_run
			road_team_road[:pitches_seen_per_game] = pitches_seen_per_game
			road_team_road[:runs_per_pitch_by_opp] = runs_per_pitch_by_opp
			road_team_road[:at_bats_per_nine] = at_bats_per_nine
			road_team_road[:hits_per_nine] = hits_per_nine
			road_team_road[:pitches_thrown_per_game] = pitches_thrown_per_game
			road_team_road[:opp_runs_per_pitch] = opp_runs_per_pitch
			road_team_road[:bullpen_rpp] = bullpen_rpp
			road_team_road[:starter_rpp] = starter_rpp

			@road_road_stats = road_team_road

		end
		
		if array == @road_vs_opp

			road_team_opp = Hash.new

			road_team_opp[:games] = array.length
			road_team_opp[:record] = team_record
			road_team_opp[:run_diff] = run_diff
			road_team_opp[:runs_per_game] = runs_per_game
			road_team_opp[:runs_against_per_game] = runs_against
			road_team_opp[:hits_per_game] = hits_per_game
			road_team_opp[:hits_against_per_game] = hits_against_per_game
			road_team_opp[:at_bats_per_game] = at_bats_per_game
			road_team_opp[:at_bats_per_run] = at_bats_per_run
			road_team_opp[:hits_needed_per_run] = hits_needed_per_run
			road_team_opp[:innings_per_run] = innings_per_run
			road_team_opp[:pitches_seen_per_game] = pitches_seen_per_game
			road_team_opp[:runs_per_pitch_by_opp] = runs_per_pitch_by_opp
			road_team_opp[:at_bats_per_nine] = at_bats_per_nine
			road_team_opp[:hits_per_nine] = hits_per_nine
			road_team_opp[:pitches_thrown_per_game] = pitches_thrown_per_game
			road_team_opp[:opp_runs_per_pitch] = opp_runs_per_pitch
			road_team_opp[:bullpen_rpp] = bullpen_rpp
			road_team_opp[:starter_rpp] = starter_rpp

			@road_opp_stats = road_team_opp

		end

		
		if array == @road_vs_pitcher

			road_team_pitcher = Hash.new

			road_team_pitcher[:games] = array.length
			road_team_pitcher[:record] = team_record
			road_team_pitcher[:run_diff] = run_diff
			road_team_pitcher[:runs_per_game] = runs_per_game
			road_team_pitcher[:hits_per_game] = hits_per_game
			road_team_pitcher[:at_bats_per_game] = at_bats_per_game
			road_team_pitcher[:at_bats_per_run] = at_bats_per_run
			road_team_pitcher[:hits_needed_per_run] = hits_needed_per_run
			road_team_pitcher[:innings_per_run] = innings_per_run
			road_team_pitcher[:pitches_seen_per_game] = pitches_seen_per_game
			road_team_pitcher[:runs_per_pitch_by_opp] = runs_per_pitch_by_opp
			road_team_pitcher[:at_bats_per_nine] = at_bats_per_nine
			road_team_pitcher[:hits_per_nine] = hits_per_nine
			road_team_pitcher[:opp_starter_freq] = opp_starter_freq_to_s
			road_team_pitcher[:opp_bullpen_freq] = opp_bullpen_freq_to_s
			road_team_pitcher[:bullpen_rpp] = bullpen_rpp
			road_team_pitcher[:starter_rpp] = starter_rpp
			road_team_pitcher[:opp_bullpen_rpp] = opp_bullpen_rpp
			road_team_pitcher[:opp_starter_rpp] = opp_starter_rpp

			@road_pitcher_stats = road_team_pitcher

		end

		if array == @road_with_pitcher

			road_team_with_pitcher = Hash.new

			road_team_with_pitcher[:games] = array.length
			road_team_with_pitcher[:record] = team_record
			road_team_with_pitcher[:run_diff] = run_diff
			road_team_with_pitcher[:starter_pitch_avg] = starter_pitch_avg
			road_team_with_pitcher[:bullpen_pitch_avg] = bullpen_pitch_avg
			road_team_with_pitcher[:at_bats_against_per_game] = opp_at_bats_per_nine
			road_team_with_pitcher[:hits_against_per_game] = hits_against_per_game
			road_team_with_pitcher[:runs_against_per_game] = runs_against
			road_team_with_pitcher[:starter_run_avg] = starter_run_avg
			road_team_with_pitcher[:bullpen_run_avg] = bullpen_run_avg
			road_team_with_pitcher[:bullpen_rpp] = bullpen_rpp
			road_team_with_pitcher[:starter_rpp] = starter_rpp
			road_team_with_pitcher[:opp_runs_per_pitch] = opp_runs_per_pitch
			road_team_with_pitcher[:innings_per_run] = innings_per_run
			road_team_with_pitcher[:pitches_thrown_per_game] = pitches_thrown_per_game
			

			road_team_with_pitcher[:runs_per_game] = runs_per_game
			road_team_with_pitcher[:opp_starter_freq] = opp_starter_freq_to_s
			road_team_with_pitcher[:opp_bullpen_freq] = opp_bullpen_freq_to_s
			
			@road_with_pitcher_stats = road_team_with_pitcher

		end
		
		if array == @road_last_ten

			road_team_last_ten = Hash.new

			road_team_last_ten[:record] = team_record
			road_team_last_ten[:run_diff] = run_diff
			road_team_last_ten[:runs_per_game] = runs_per_game
			road_team_last_ten[:runs_against_per_game] = runs_against
			road_team_last_ten[:hits_per_game] = hits_per_game
			road_team_last_ten[:hits_against_per_game] = hits_against_per_game
			road_team_last_ten[:at_bats_per_game] = at_bats_per_game
			road_team_last_ten[:at_bats_against_per_game] = at_bats_against_per_game
			road_team_last_ten[:at_bats_per_run] = at_bats_per_run
			road_team_last_ten[:hits_needed_per_run] = hits_needed_per_run
			road_team_last_ten[:innings_per_run] = innings_per_run
			road_team_last_ten[:pitches_seen_per_game] = pitches_seen_per_game
			road_team_last_ten[:runs_per_pitch_by_opp] = runs_per_pitch_by_opp
			road_team_last_ten[:at_bats_per_nine] = at_bats_per_nine
			road_team_last_ten[:hits_per_nine] = hits_per_nine
			road_team_last_ten[:pitches_thrown_per_game] = pitches_thrown_per_game
			road_team_last_ten[:opp_runs_per_pitch] = opp_runs_per_pitch
			road_team_last_ten[:starter_freq_to_string] = starter_freq_to_string
			road_team_last_ten[:bullpen_freq_to_string] = bullpen_freq_to_string
			road_team_last_ten[:bullpen_rpp] = bullpen_rpp
			road_team_last_ten[:starter_rpp] = starter_rpp

			@road_last_ten_stats = road_team_last_ten


		end


	end

	

	




















	def get_all_home_team_matchups (sport, team)

		Matchup.all.each do |m|

			if m.fav == team || m.dog == team

				if m.winner.length !=0

					@home_team_matchups.push(m)

				end


			end

		end


	end

	def get_all_road_team_matchups(sports, team)

		Matchup.all.each do |m|

			if m.fav == team || m.dog == team

				if m.winner.length != 0

					@road_team_matchups.push(m)

				end


			end

		end

	end

	def analyze_home_matchups(team, sport)

		@home_team_matchups.each do |m|

			if m.fav == team

				@all_home_matchups.push(m)

				if m.fav_field == "home"

					if m.spread < 3

						@road_dog_under3.push(m)


					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@road_dog_under7.push(m)
					

					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@road_dog_under10.push(m)
					

					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@road_dog_under14.push(m)


					else

						@road_dog_14_or_more.push(m)


					end


				else

					if m.spread < 3

						@home_dog_under3.push(m)


					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@home_dog_under7.push(m)
					

					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@home_dog_under10.push(m)
					

					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@home_dog_under14.push(m)


					else

						@home_dog_14_or_more.push(m)


					end

				end

			elsif m.dog == team

				@all_home_matchups.push(m)

				if m.dog_field == "home"

					if m.spread < 3

						@road_fave_under3.push(m)

					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@road_fave_under7.push(m)
					
					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@road_fave_under10.push(m)
					
					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@road_fave_under14.push(m)

					else

						@road_fave_14_or_more.push(m)

					end
				
				else

					if m.spread < 3

						@home_fave_under3.push(m)


					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@home_fave_under7.push(m)
					

					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@home_fave_under10.push(m)
					

					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@home_fave_under14.push(m)


					else

						@home_fave_14_or_more.push(m)


					end


				end

			end

		end

	end

	def analyze_road_matchups(sport, team)

		@road_team_matchups.each do |m|

			if m.fav == team

				@all_road_matchups.push(m)

				if m.fav_field == "home"

					if m.spread < 3

						@R_road_dog_under3.push(m)


					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@R_road_dog_under7.push(m)
					

					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@R_road_dog_under10.push(m)
					

					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@R_road_dog_under14.push(m)


					else

						@R_road_dog_14_or_more.push(m)


					end


				else

					if m.spread < 3

						@R_home_dog_under3.push(m)


					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@R_home_dog_under7.push(m)
					

					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@R_home_dog_under10.push(m)
					

					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@R_home_dog_under14.push(m)


					else

						@R_home_dog_14_or_more.push(m)


					end

				end

			elsif m.dog == team

				@all_road_matchups.push(m)

				if m.dog_field == "home"

					if m.spread < 3

						@R_road_fave_under3.push(m)


					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@R_road_fave_under7.push(m)
					

					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@R_road_fave_under10.push(m)
					

					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@R_road_fave_under14.push(m)


					else

						@R_road_fave_14_or_more.push(m)


					end

				
				else

					if m.spread < 3

						@R_home_fave_under3.push(m)


					elsif m.spread.to_f >= 3 || m.spread.to_f < 7

						@R_home_fave_under7.push(m)
					

					elsif m.spread.to_f >= 7 || m.spread.to_f < 10

						@R_home_fave_under10.push(m)
					

					elsif m.spread.to_f >= 10 || m.spread.to_f < 14

						@R_home_fave_under14.push(m)


					else

						@R_home_fave_14_or_more.push(m)


					end


				end

			end

		end

	end

	
	def compute_home_amv

		score_holder = []

		@all_home_matchups.each do |m|

			if m.fav == @matchup.fav

				if m.fav_field == "home"

					num = m.home_score.to_i - m.road_score.to_i

					score_holder.push(num)


				else

					num = m.road_score.to_i - m.home_score

					score_holder.push(num)


				end


			else m.dog == @matchup.fav

				if m.dog_field == "home"

					num = m.home_score.to_i - m.road_score.to_i

					score_holder.push(num)

				else

					num = m.road_score.to_i - m.home_score.to_i

					score_holder.push(num)


				end

			end

		end

		sum = score_holder.inject(0){|sum,x| sum + x }

		sum = sum.to_f

		games = score_holder.length.to_f

		@home_amv = sum / games 

	end

	
	def compute_road_amv

		score_holder = []

		@all_road_matchups.each do |m|

			if m.fav == @matchup.dog

				if m.fav_field == "home"

					num = m.home_score.to_i - m.road_score.to_i

					score_holder.push(num)


				else

					num = m.road_score.to_i - m.home_score

					score_holder.push(num)


				end


			else m.dog == @matchup.dog

				if m.dog_field == "home"

					num = m.home_score.to_i - m.road_score.to_i

					score_holder.push(num)

				else

					num = m.road_score.to_i - m.home_score.to_i

					score_holder.push(num)


				end

			end

		end

		sum = score_holder.inject(0){|sum,x| sum + x }

		sum = sum.to_f

		games = score_holder.length.to_f

		@road_amv = sum / games

	end

	def get_home_situation(team, spread)

		if spread < 3

			if team == @matchup.fav

				@home_current_situation = "home fav under 3"

			else

				@home_current_situation = "home dog under 3"
	
			end

		elsif spread >= 3 && spread < 7

			if team == @matchup.fav

				@home_current_situation = "home fav 3 - 6.5"

					
			else

				@home_current_situation = "home dog 3 - 6.5"

			end
		
		elsif spread >= 7 && spread < 10

			if team == @matchup.fav

				@home_current_situation = "home fav 7 - 9.5"

			else

				@home_current_situation = "home dog 7 - 9.5"

			end

		
		elsif spread >= 10 && spread < 14

			if team == @matchup.fav

				@home_current_situation = "home fav 10 - 13.5"

			else

				@home_current_situation = "home dog 10 - 13.5"

			end

		elsif spread >= 14

			if team == @matchup.fav

				@home_current_situation = "home fav 14 or more"

				
			else	

				@home_current_situation = "home dog 14 or more"
	
			end

		end

	end

	def get_road_situation(team, spread)

		if spread < 3

			if team == @matchup.fav

				@road_current_situation = "road fav under 3"

			else

				@road_home_current_situation = "road dog under 3"
	
			end

		elsif spread >= 3 && spread < 7

			if team == @matchup.fav

				@road_current_situation = "road fav 3 - 6.5"

					
			else

				@road_current_situation = "road dog 3 - 6.5"

			end
		
		elsif spread >= 7 && spread < 10

			if team == @matchup.fav

				@road_current_situation = "road fav 7 - 9.5"

			else

				@road_current_situation = "road dog 7 - 9.5"

			end

		
		elsif spread >= 10 && spread < 14

			if team == @matchup.fav

				@road_current_situation = "road fav 10 - 13.5"

			else

				@road_current_situation = "road dog 10 - 13.5"

			end

		elsif spread >= 14

			if team == @matchup.fav

				@road_current_situation = "road fav 14 or more"

				
			else	

				@road_current_situation = "road dog 14 or more"
	
			end

		end

	end

	def get_home_amv(team, situation)

		if situatiom == "home fav under 3"

			@all_home_matchups.each do |m|

				if team == m.fav && m.fav_field == "home"

					if m.spread < 3

						num = m.home_score.to_i - m.road_score.to_i

						@situation_amv.push(num)

					end


				end


			end

		elsif situation == "home fav 3 - 6.5"

			@all_home_matchups.each do |m|

				if team == m.fav && m.fav_field == "home"

					if m.spread.to_f >= 3 && m.spread.to_f < 7

						num = m.home_score.to_i - m.road_score.to_i

						@situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "home fav 7 - 9.5"

			@all_home_matchups.each do |m|

				if team == m.fav && m.fav_field == "home"

					if m.spread.to_f >= 7 && m.spread.to_f < 10

						num = m.home_score.to_i - m.road_score.to_i

						@situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "home fav 10 - 13.5"

			@all_home_matchups.each do |m|

				if team == m.fav && m.fav_field == "home"

					if m.spread.to_f >= 10 && m.spread.to_f < 14

						num = m.home_score.to_i - m.road_score.to_i

						@situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "home fav 14 or more"

			@all_home_matchups.each do |m|

				if team == m.fav && m.fav_field == "home"

					if m.spread.to_f >= 14

						num = m.home_score.to_i - m.road_score.to_i

						@situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "home dog 14 or more"

			@all_home_matchups.each do |m|

				if team == m.dog && m.dog_field == "home"

					if m.spread.to_f >= 14 

						num = m.home_score.to_i - m.road_score.to_i

						@situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "home dog 10 - 13.5"

			@all_home_matchups.each do |m|

				if team == m.dog && m.dog_field == "home"

					if m.spread.to_f >= 10 && m.spread.to_f < 14

						num = m.home_score.to_i - m.road_score.to_i

						@situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "home dog 7 - 9.5"

			@all_home_matchups.each do |m|

				if team == m.dog && m.dog_field == "home"

					if m.spread.to_f >= 7 && m.spread.to_f < 10

						num = m.home_score.to_i - m.road_score.to_i

						@situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "home dog 3 - 6.5"

			@all_home_matchups.each do |m|

				if team == m.dog && m.dog_field == "home"

					if m.spread.to_f >= 3 && m.spread.to_f < 7

						num = m.home_score.to_i - m.road_score.to_i

						@situation_amv.push(num)

					end


				end


			end

		elsif situation == "home dog under 3"

			@all_home_matchups.each do |m|

				if team == m.dog && m.dog_field == "home"

					if m.spread.to_f < 3 

						num = m.home_score.to_i - m.road_score.to_i

						@situation_amv.push(num)

					end


				end


			end

		end

		sum = @situation_amv.inject(0){|sum,x| sum + x }

		sum = sum.to_f

		games = @situation.length.to_f

		@situation_amv =  sum / games

	end

	def get_road_amv(team, situation)

		if situatiom == "road fav under 3"

			@all_road_matchups.each do |m|

				if team == m.fav && m.fav_field != "home"

					if m.spread < 3

						num = m.road_score.to_i - m.home_score.to_i

						@road_situation_amv.push(num)

					end


				end


			end

		elsif situation == "road fav 3 - 6.5"

			@all_road_matchups.each do |m|

				if team == m.fav && m.fav_field != "home"

					if m.spread.to_f >= 3 && m.spread.to_f < 7

						num = m.road_score.to_i - m.home_score.to_i

						@road_situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "road fav 7 - 9.5"

			@all_road_matchups.each do |m|

				if team == m.fav && m.fav_field != "home"

					if m.spread.to_f >= 7 && m.spread.to_f < 10

						num = m.road_score.to_i - m.home_score.to_i

						@road_situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "road fav 10 - 13.5"

			@all_road_matchups.each do |m|

				if team == m.fav && m.fav_field != "home"

					if m.spread.to_f >= 10 && m.spread.to_f < 14

						num = m.road_score.to_i - m.home_score.to_i

						@road_situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "road fav 14 or more"

			@all_road_matchups.each do |m|

				if team == m.fav && m.fav_field != "home"

					if m.spread.to_f >= 14

						num = m.road_score.to_i - m.home_score.to_i

						@road_situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "road dog 14 or more"

			@all_road_matchups.each do |m|

				if team == m.dog && m.dog_field != "home"

					if m.spread.to_f >= 14

						num = m.road_score.to_i - m.home_score.to_i

						@road_situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "road dog 10 - 13.5"

			@all_road_matchups.each do |m|

				if team == m.dog && m.dog_field != "home"

					if m.spread.to_f >= 10 && m.spread < 14

						num = m.road_score.to_i - m.home_score.to_i

						@road_situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "road dog 7 - 9.5"

			@all_road_matchups.each do |m|

				if team == m.dog && m.dog_field != "home"

					if m.spread.to_f >= 7 && m.spread < 10

						num = m.road_score.to_i - m.home_score.to_i

						@road_situation_amv.push(num)

					end


				end


			end
		
		elsif situation == "road dog 3 - 6.5"

			@all_home_matchups.each do |m|

				if team == m.dog && m.dog_field == "home"

					if m.spread.to_f >= 3 && m.spread.to_f < 7

						num = m.home_score.to_i - m.road_score.to_i

						@situation_amv.push(num)

					end


				end


			end

		elsif situation == "road dog under 3"

			@all_road_matchups.each do |m|

				if team == m.dog && m.dog_field != "home"

					if m.spread.to_f < 3 

						num = m.road_score.to_i - m.home_score.to_i

						@road_situation_amv.push(num)

					end

				end

			end

		end

		sum = @road_situation_amv.inject(0){|sum,x| sum + x }.to_f

		games = @road_situation.length.to_f

		@situation_amv =  sum / games

	end




	def get_games_vs_team_home(team_abbr)

		@home_game_logs.each do |h|

			if h.opp == team_abbr

				@home_vs_opp.push(h)

			end

		end


	end

	def get_games_vs_team_away(team_abbr)

		@away_game_logs.each do |h|

			if h.opp == team_abbr

				@away_vs_opp.push(h)

			end

		end


	end

	def get_home_vs_pitcher(pitcher)

		@home_game_logs.each do |h|

			if h.opp_starting_pitcher == pitcher

				@home_vs_pitcher.push(h)

			end

		end

	end

	def get_away_vs_pitcher(pitcher)

		@away_game_logs.each do |h|

			if h.opp_starting_pitcher == pitcher

				@away_vs_pitcher.push(h)

			end

		end

	end

	def get_all_pitchers

		MlbGameLog.all.each do |m|

			@nl_pitchers.push(m.team_starting_pitcher) unless @nl_pitchers.include?(m.team_starting_pitcher)


		end


	end

	def create_rating_objects

		@nl_pitchers.each do |n|

			ratings = []

			games = []

			MlbGameLog.all.each do |m|

				if m.team_starting_pitcher == n	

					games.push(m)				

				end

				


			end

			games.each do |g|

				rating = (g.team_starter_pitches.to_f / g.runs_by_team_starter.to_f).round(2)
				ratings.push(rating)


			end

			avg_rating = ((ratings.inject(0){|sum,x| sum + x }).to_f / ratings.length.to_f).round(2)

			counter = 0
			home_counter = 0
			away_counter = 0
			home_games = 0
			away_games = 0
			
			ratings.last(3).each do |r|

				counter += r


			end

			last_three_rating = (counter.to_f / 3.0).round(2)

			games.each do |g|

				if g.home == "true"

					home_counter += g.team_starter_pitches.to_f

					home_games += g.runs_by_team_starter.to_f

				elsif g.home == "false"

					away_counter += g.team_starter_pitches.to_f

					away_games += g.runs_by_team_starter.to_f

				end

			end

			home_rating = (home_counter.to_f / home_games.to_f).round(2)
			away_rating = (away_counter.to_f / away_games.to_f).round(2)



			player_ratings = Hash.new
			
			player_ratings[:pitcher] = n
			player_ratings[:all_ratings] = ratings
			player_ratings[:home_rating] = home_rating
			player_ratings[:away_rating] = away_rating
			player_ratings[:last_three] = last_three_rating
			player_ratings[:overall_rating] = avg_rating

			@pitchers_and_ratings.push(player_ratings)


		end

	end
end
