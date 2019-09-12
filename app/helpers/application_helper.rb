module ApplicationHelper

	def get_time

  			 @date = Time.now.utc
  			 @date = @date.in_time_zone('Eastern Time (US & Canada)') 
			 @day = @date.strftime("%d")
			 @month = @date.strftime("%b") 
			 @year = @date.strftime("%Y") 


			 @my_date = @day << " " <<@month << " " <<@year 

  	end

  	def convert_my_date

		@my_month = @my_date[3] + @my_date[4] + @my_date[5] 

		if @my_month == "Jan"

			@my_month = "01"

		elsif @my_month == "Feb"

			@my_month = "02"

		elsif @my_month == "Mar"

			@my_month = "03"

		elsif @my_month == "Apr"

			@my_month = "04"

		elsif @my_month == "May"

			@my_month = "05"

		elsif @my_month == "Jun"

			@my_month = "06"

		elsif @my_month == "Jul"

			@my_month = "07"

		elsif @my_month == "Aug"

			@my_month = "08"

		elsif @my_month == "Sep"

			@my_month = "09"

		elsif @my_month == "Oct"

			@my_month = "10"

		elsif @my_month == "Nov"

			@my_month = "11"

		elsif @my_month == "Dec"

			@my_month = "12"

		end

		@my_date = @my_date[7] + @my_date[8] + @my_date[9] + @my_date[10] + @my_month + @my_date[0] + @my_date[1] 
		@my_date = @my_date.to_i


	end

	def convert_date(date)

		@my_month = date[3] + date[4] + date[5] 

		if @my_month == "Jan"

			@my_month = "01"

		elsif @my_month == "Feb"

			@my_month = "02"

		elsif @my_month == "Mar"

			@my_month = "03"

		elsif @my_month == "Apr"

			@my_month = "04"

		elsif @my_month == "May"

			@my_month = "05"

		elsif @my_month == "Jun"

			@my_month = "06"

		elsif @my_month == "Jul"

			@my_month = "07"

		elsif @my_month == "Aug"

			@my_month = "08"

		elsif @my_month == "Sep"

			@my_month = "09"

		elsif @my_month == "Oct"

			@my_month = "10"

		elsif @my_month == "Nov"

			@my_month = "11"

		elsif @my_month == "Dec"

			@my_month = "12"

		end

		@matchup_date = date[7] + date[8] + date[9] + date[10] + @my_month + date[0] + date[1] 
		@matchup_date = @matchup_date.to_i


	end

	def load_home_team_stats(team_obj)

		starter_pitches = 0
		bullpen_pitches = 0
		runs_for = 0
		runs_against = 0
		hits_for = 0
		hits_against = 0
		at_bats_for = 0
		at_bats_against = 0
		innings = 0
		opp_starter_pitches = 0
		opp_bullpen_pitches = 0

		MlbGameLog.all.each do |m|

			if m.team_id.to_i == team_obj.id

				starter_pitches += m.team_starter_pitches.to_i
				bullpen_pitches += m.team_bullpen_picthes.to_i
				runs_for += m.team_runs.to_i
				runs_against += m.opp_runs.to_i
				hits_for += m.team_hits.to_i
				hits_against += m.opp_hits.to_i
				at_bats_for += m.at_bats_for.to_i
				at_bats_against += m.at_bats_against.to_i
				innings += m.innings.to_i
				opp_starter_pitches += m.opp_starter_pitches.to_i
				opp_bullpen_pitches += m.opp_bullpen_picthes.to_i
				

			end

			


		end

		@home_innings = innings 
		@home_runs_scored  = runs_for
		@home_runs_against = runs_against
		@home_hits_for = hits_for
		@home_hits_against = hits_against
		@home_all_starters_pitches = starter_pitches 
		@home_all_bullpen_pitches = bullpen_pitches 
		@home_pitches_total = @home_all_starters_pitches + @home_all_bullpen_pitches 
		@home_at_bats_total = at_bats_for
		@home_at_bats_per_nine = at_bats_for.to_f/innings
		@home_errors 
		@home_all_opp_starter_pitches = opp_starter_pitches
		@home_all_opp_bullpen_pitches = opp_bullpen_pitches
		@home_all_opp_pitches = opp_starter_pitches + opp_bullpen_pitches


	end

	def load_road_team_stats(team_obj)

		@starter_pitches = 0
		@bullpen_pitches = 0
		@runs_for = 0
		@runs_against = 0
		@hits_for = 0
		@hits_against = 0
		@at_bats_for = 0
		@at_bats_against = 0
		@innings = 0
		@opp_starter_pitches = 0
		@opp_bullpen_pitches = 0

		MlbGameLog.all.each do |m|

			if m.team_id.to_i == team_obj.id

				@starter_pitches += m.team_starter_pitches.to_i
				@bullpen_pitches += m.team_bullpen_picthes.to_i
				@runs_for += m.team_runs.to_i
				@runs_against += m.opp_runs.to_i
				@hits_for += m.team_hits.to_i
				@hits_against += m.opp_hits.to_i
				@at_bats_for += m.at_bats_for.to_i
				@at_bats_against += m.at_bats_against.to_i
				@innings += m.innings.to_i
				@opp_starter_pitches += m.opp_starter_pitches.to_i
				@opp_bullpen_pitches += m.opp_bullpen_picthes.to_i
				

			end

			


		end

		@road_innings = @innings 
		@road_runs_scored  = @runs_for
		@road_runs_against = @runs_against
		@road_hits_for = @hits_for
		@road_hits_against = @hits_against
		@road_all_starters_pitches = @starter_pitches 
		@road_all_bullpen_pitches = @bullpen_pitches 
		@road_pitches_total = @road_all_starters_pitches + @road_all_bullpen_pitches 
		@road_at_bats_total = @at_bats_for
		@road_at_bats_per_nine = @at_bats_for.to_f/@innings
		@road_errors 
		@road_all_opp_starter_pitches = @opp_starter_pitches
		@road_all_opp_bullpen_pitches = @opp_bullpen_pitches
		@road_all_opp_pitches = @opp_starter_pitches + @opp_bullpen_pitches

	end

	def get_team_rankings

		Team.all.each do |t|

			if t.div_or_conf == "NL East" || t.div_or_conf == "NL Central" || t.div_or_conf == "NL West"

				starter_pitches = 0
				bullpen_pitches = 0
				@bullpen_runs = 0
				runs_for = 0
				runs_against = 0
				hits_for = 0
				hits_against = 0
				at_bats_for = 0
				at_bats_against = 0
				innings = 0
				opp_starter_pitches = 0
				opp_bullpen_pitches = 0
				team_errors = 0
				opp_errors = 0

				team_stats = Hash.new

				team_stats[:team_name] = t.team_name
				team_stats[:runs_for] = 0
				team_stats[:at_bats_for] = 0
				team_stats[:at_bats_per_nine] = 0
				team_stats[:runs_per_ab] = 0
				team_stats[:hits_per_nine] = 0
				team_stats[:hits_per_run] = 0
				team_stats[:runs_per_inning] = 0
				team_stats[:pitches_seen_per_game] = 0
				team_stats[:runs_for_per_pitch] = 0
				team_stats[:starter_workload] = 0
				team_stats[:bullpen_workload] = 0
				team_stats[:opp_starter_workload] = 0
				team_stats[:opp_bullpen_workload] = 0
				team_stats[:quality_at_bats_per_run] = 0
				team_stats[:opp_quality_at_bats_per_run] = 0
				
				team_stats[:runs_against] = 0
				team_stats[:at_bats_against] = 0
				team_stats[:at_bats_against_per_nine] = 0
				team_stats[:runs_against_per_ab] = 0
				team_stats[:opp_hits_per_nine] = 0
				team_stats[:opp_hits_per_run] = 0
				team_stats[:opp_runs_per_inning] = 0
				team_stats[:team_pitches_per_game] = 0
				team_stats[:opp_runs_per_pitch] = 0
				team_stats[:bullpen_runs_per_pitch] = 0




				MlbGameLog.all.each do |m|

					if t.id == m.team_id.to_i

						starter_pitches += m.team_starter_pitches.to_i
						bullpen_pitches += m.team_bullpen_picthes.to_i
						runs_for += m.team_runs.to_i
						runs_against += m.opp_runs.to_i
						@bullpen_runs += m.runs_by_team_bullpen.to_i
						hits_for += m.team_hits.to_i
						hits_against += m.opp_hits.to_i
						at_bats_for += m.at_bats_for.to_i
						at_bats_against += m.at_bats_against.to_i
						innings += m.innings.to_i
						opp_starter_pitches += m.opp_starter_pitches.to_i
						opp_bullpen_pitches += m.opp_bullpen_picthes.to_i
						team_errors += m.team_errors.to_i
						opp_errors += m.opp_errors.to_i


							

						runs_per_at_bat = (1.0 / (runs_for.to_f / at_bats_for.to_f)).round(2)
						hits_needed_per_run = (hits_for.to_f / runs_for.to_f).round(2)
						runs_per_inning = (runs_for.to_f / innings.to_f).round(2)
						pitches_seen_per_game = ((opp_starter_pitches.to_f + opp_bullpen_pitches.to_f) / innings.to_f).round(2) * 9 
						runs_per_pitch_by_opp = (runs_for.to_f / (opp_starter_pitches.to_f + opp_bullpen_pitches.to_f)).round(3)
						at_bats_per_nine = ((at_bats_for.to_f/innings.to_f) * 9).round(2)
						hits_per_nine = (hits_for.to_f / innings.to_f).round(2) * 9

						runs_against_per_at_bat = (1.0 / (runs_against.to_f / at_bats_against.to_f)).round(2)
						opp_hits_needed_per_run = (hits_against.to_f / runs_against.to_f).round(2)
						opp_runs_per_inning = (runs_against.to_f / innings.to_f).round(2)
						opp_at_bats_per_nine = ((at_bats_against.to_f/innings.to_f).round(2) * 9).round(2)
						opp_hits_per_nine = ((hits_against.to_f / innings.to_f).round(2) * 9).round(2)

						pitches_thrown_per_game = ((starter_pitches.to_f + bullpen_pitches.to_f) / innings.to_f).round(2) * 9
						opp_runs_per_pitch = (runs_against.to_f / pitches_thrown_per_game).round(2)

						starter_freq = ((starter_pitches.to_f / (starter_pitches + bullpen_pitches).to_f) * 100).round(2)
						starter_freq_to_string = starter_freq.to_s + "%"
						bullpen_freq = (100.0 - starter_freq).round(2)
						bullpen_freq_to_string = bullpen_freq.to_s + "%"
						bullpen_rpp = (@bullpen_runs.to_f / bullpen_pitches.to_f).round(3)

						opp_starter_freq = ((opp_starter_pitches.to_f / (opp_starter_pitches + opp_bullpen_pitches).to_f) * 100).round(2)
						opp_bullpen_freq = (100.00 - opp_starter_freq).round(2)
						opp_starter_freq_to_s = opp_starter_freq.to_s + "%"
						opp_bullpen_freq_to_s = opp_bullpen_freq.to_s + "%"


						good_at_bats_per_run = (at_bats_for.to_f - (innings * 3) / runs_for.to_f).round(2)

						opp_good_at_bats_per_run = (at_bats_against.to_f - (innings * 3) / runs_against.to_f).round(2)  

						
						team_stats[:runs_for] = ((runs_for.to_f / innings.to_f) * 9).round(2)
						team_stats[:at_bats_for] = at_bats_for.to_f
						team_stats[:at_bats_per_nine] = at_bats_per_nine.to_f
						team_stats[:runs_per_ab] = runs_per_at_bat.to_f
						team_stats[:hits_per_nine] = hits_per_nine.to_f
						team_stats[:hits_per_run] = hits_needed_per_run.to_f
						team_stats[:runs_per_inning] = runs_per_inning.to_f
						team_stats[:pitches_seen_per_game] = pitches_seen_per_game.to_f
						team_stats[:runs_for_per_pitch] = runs_per_pitch_by_opp
						team_stats[:starter_workload] = starter_freq_to_string
						team_stats[:bullpen_workload] = bullpen_freq_to_string
						team_stats[:opp_starter_workload] = opp_starter_freq_to_s
						team_stats[:opp_bullpen_workload] = opp_bullpen_freq_to_s
						team_stats[:quality_at_bats_per_run] = good_at_bats_per_run
						team_stats[:opp_quality_at_bats_per_run] = opp_good_at_bats_per_run
						
						team_stats[:runs_against] = ((runs_against.to_f / innings.to_f) * 9).round(2)
						team_stats[:at_bats_against] = at_bats_against
						team_stats[:at_bats_against_per_nine] = opp_at_bats_per_nine
						team_stats[:runs_against_per_ab] = runs_against_per_at_bat
						team_stats[:opp_hits_per_nine] = opp_hits_per_nine
						team_stats[:opp_hits_per_run] = opp_hits_needed_per_run
						team_stats[:opp_runs_per_inning] = opp_runs_per_inning
						team_stats[:team_pitches_per_game] = pitches_thrown_per_game
						team_stats[:opp_runs_per_pitch] = opp_runs_per_pitch
						team_stats[:bullpen_runs_per_pitch] = bullpen_rpp

						

					end

				end

				@team_holder.push(team_stats)

			end


		end


	end

	def get_team_rankings_last_three

		Team.all.each do |t|

			if t.div_or_conf == "NL East" || t.div_or_conf == "NL Central" || t.div_or_conf == "NL West"

				starter_pitches = 0
				bullpen_pitches = 0
				@bullpen_runs = 0
				runs_for = 0
				runs_against = 0
				hits_for = 0
				hits_against = 0
				at_bats_for = 0
				at_bats_against = 0
				innings = 0
				opp_starter_pitches = 0
				opp_bullpen_pitches = 0
				team_errors = 0
				opp_errors = 0

				team_stats = Hash.new

				team_stats[:team_name] = t.team_name
				team_stats[:runs_for] = 0
				team_stats[:at_bats_for] = 0
				team_stats[:at_bats_per_nine] = 0
				team_stats[:runs_per_ab] = 0
				team_stats[:hits_per_nine] = 0
				team_stats[:hits_per_run] = 0
				team_stats[:runs_per_inning] = 0
				team_stats[:pitches_seen_per_game] = 0
				team_stats[:runs_for_per_pitch] = 0
				team_stats[:starter_workload] = 0
				team_stats[:bullpen_workload] = 0
				team_stats[:opp_starter_workload] = 0
				team_stats[:opp_bullpen_workload] = 0
				team_stats[:quality_at_bats_per_run] = 0
				team_stats[:opp_quality_at_bats_per_run] = 0
				
				team_stats[:runs_against] = 0
				team_stats[:at_bats_against] = 0
				team_stats[:at_bats_against_per_nine] = 0
				team_stats[:runs_against_per_ab] = 0
				team_stats[:opp_hits_per_nine] = 0
				team_stats[:opp_hits_per_run] = 0
				team_stats[:opp_runs_per_inning] = 0
				team_stats[:team_pitches_per_game] = 0
				team_stats[:opp_runs_per_pitch] = 0
				team_stats[:bullpen_runs_per_pitch] = 0




				t.mlb_game_logs.last(3).each do |m|

					starter_pitches += m.team_starter_pitches.to_i
					bullpen_pitches += m.team_bullpen_picthes.to_i
					runs_for += m.team_runs.to_i
					runs_against += m.opp_runs.to_i
					@bullpen_runs += m.runs_by_team_bullpen.to_i
					hits_for += m.team_hits.to_i
					hits_against += m.opp_hits.to_i
					at_bats_for += m.at_bats_for.to_i
					at_bats_against += m.at_bats_against.to_i
					innings += m.innings.to_i
					opp_starter_pitches += m.opp_starter_pitches.to_i
					opp_bullpen_pitches += m.opp_bullpen_picthes.to_i
					team_errors += m.team_errors.to_i
					opp_errors += m.opp_errors.to_i


						

					runs_per_at_bat = (1.0 / (runs_for.to_f / at_bats_for.to_f)).round(2)
					hits_needed_per_run = (hits_for.to_f / runs_for.to_f).round(2)
					runs_per_inning = (runs_for.to_f / innings.to_f).round(2)
					pitches_seen_per_game = ((opp_starter_pitches.to_f + opp_bullpen_pitches.to_f) / innings.to_f).round(2) * 9 
					runs_per_pitch_by_opp = (runs_for.to_f / (opp_starter_pitches.to_f + opp_bullpen_pitches.to_f)).round(3)
					at_bats_per_nine = ((at_bats_for.to_f/innings.to_f) * 9).round(2)
					hits_per_nine = (hits_for.to_f / innings.to_f).round(2) * 9

					runs_against_per_at_bat = (1.0 / (runs_against.to_f / at_bats_against.to_f)).round(2)
					opp_hits_needed_per_run = (hits_against.to_f / runs_against.to_f).round(2)
					opp_runs_per_inning = (runs_against.to_f / innings.to_f).round(2)
					opp_at_bats_per_nine = ((at_bats_against.to_f/innings.to_f).round(2) * 9).round(2)
					opp_hits_per_nine = ((hits_against.to_f / innings.to_f).round(2) * 9).round(2)

					pitches_thrown_per_game = ((starter_pitches.to_f + bullpen_pitches.to_f) / innings.to_f).round(2) * 9
					opp_runs_per_pitch = (runs_against.to_f / pitches_thrown_per_game).round(2)

					starter_freq = ((starter_pitches.to_f / (starter_pitches + bullpen_pitches).to_f) * 100).round(2)
					starter_freq_to_string = starter_freq.to_s + "%"
					bullpen_freq = (100.0 - starter_freq).round(2)
					bullpen_freq_to_string = bullpen_freq.to_s + "%"
					bullpen_rpp = (@bullpen_runs.to_f / bullpen_pitches.to_f).round(3)

					opp_starter_freq = ((opp_starter_pitches.to_f / (opp_starter_pitches + opp_bullpen_pitches).to_f) * 100).round(2)
					opp_bullpen_freq = (100.00 - opp_starter_freq).round(2)
					opp_starter_freq_to_s = opp_starter_freq.to_s + "%"
					opp_bullpen_freq_to_s = opp_bullpen_freq.to_s + "%"


					good_at_bats_per_run = (at_bats_for.to_f - (innings * 3) / runs_for.to_f).round(2)

					opp_good_at_bats_per_run = (at_bats_against.to_f - (innings * 3) / runs_against.to_f).round(2)  

					
					team_stats[:runs_for] = ((runs_for.to_f / innings.to_f) * 9).round(2)
					team_stats[:at_bats_for] = at_bats_for.to_f
					team_stats[:at_bats_per_nine] = at_bats_per_nine.to_f
					team_stats[:runs_per_ab] = runs_per_at_bat.to_f
					team_stats[:hits_per_nine] = hits_per_nine.to_f
					team_stats[:hits_per_run] = hits_needed_per_run.to_f
					team_stats[:runs_per_inning] = runs_per_inning.to_f
					team_stats[:pitches_seen_per_game] = pitches_seen_per_game.to_f
					team_stats[:runs_for_per_pitch] = runs_per_pitch_by_opp
					team_stats[:starter_workload] = starter_freq_to_string
					team_stats[:bullpen_workload] = bullpen_freq_to_string
					team_stats[:opp_starter_workload] = opp_starter_freq_to_s
					team_stats[:opp_bullpen_workload] = opp_bullpen_freq_to_s
					team_stats[:quality_at_bats_per_run] = good_at_bats_per_run
					team_stats[:opp_quality_at_bats_per_run] = opp_good_at_bats_per_run
					
					team_stats[:runs_against] = ((runs_against.to_f / innings.to_f) * 9).round(2)
					team_stats[:at_bats_against] = at_bats_against
					team_stats[:at_bats_against_per_nine] = opp_at_bats_per_nine
					team_stats[:runs_against_per_ab] = runs_against_per_at_bat
					team_stats[:opp_hits_per_nine] = opp_hits_per_nine
					team_stats[:opp_hits_per_run] = opp_hits_needed_per_run
					team_stats[:opp_runs_per_inning] = opp_runs_per_inning
					team_stats[:team_pitches_per_game] = pitches_thrown_per_game
					team_stats[:opp_runs_per_pitch] = opp_runs_per_pitch
					team_stats[:bullpen_runs_per_pitch] = bullpen_rpp

					

				end

				@team_holder.push(team_stats)

			end


		end


	end

	def get_team_rankings_last_ten

		Team.all.each do |t|

			if t.div_or_conf == "NL East" || t.div_or_conf == "NL Central" || t.div_or_conf == "NL West"

				starter_pitches = 0
				bullpen_pitches = 0
				@bullpen_runs = 0
				runs_for = 0
				runs_against = 0
				hits_for = 0
				hits_against = 0
				at_bats_for = 0
				at_bats_against = 0
				innings = 0
				opp_starter_pitches = 0
				opp_bullpen_pitches = 0
				team_errors = 0
				opp_errors = 0

				team_stats = Hash.new

				team_stats[:team_name] = t.team_name
				team_stats[:runs_for] = 0
				team_stats[:at_bats_for] = 0
				team_stats[:at_bats_per_nine] = 0
				team_stats[:runs_per_ab] = 0
				team_stats[:hits_per_nine] = 0
				team_stats[:hits_per_run] = 0
				team_stats[:runs_per_inning] = 0
				team_stats[:pitches_seen_per_game] = 0
				team_stats[:runs_for_per_pitch] = 0
				team_stats[:starter_workload] = 0
				team_stats[:bullpen_workload] = 0
				team_stats[:opp_starter_workload] = 0
				team_stats[:opp_bullpen_workload] = 0
				team_stats[:quality_at_bats_per_run] = 0
				team_stats[:opp_quality_at_bats_per_run] = 0
				
				team_stats[:runs_against] = 0
				team_stats[:at_bats_against] = 0
				team_stats[:at_bats_against_per_nine] = 0
				team_stats[:runs_against_per_ab] = 0
				team_stats[:opp_hits_per_nine] = 0
				team_stats[:opp_hits_per_run] = 0
				team_stats[:opp_runs_per_inning] = 0
				team_stats[:team_pitches_per_game] = 0
				team_stats[:opp_runs_per_pitch] = 0
				team_stats[:bullpen_runs_per_pitch] = 0




				t.mlb_game_logs.last(10).each do |m|

					starter_pitches += m.team_starter_pitches.to_i
					bullpen_pitches += m.team_bullpen_picthes.to_i
					runs_for += m.team_runs.to_i
					runs_against += m.opp_runs.to_i
					@bullpen_runs += m.runs_by_team_bullpen.to_i
					hits_for += m.team_hits.to_i
					hits_against += m.opp_hits.to_i
					at_bats_for += m.at_bats_for.to_i
					at_bats_against += m.at_bats_against.to_i
					innings += m.innings.to_i
					opp_starter_pitches += m.opp_starter_pitches.to_i
					opp_bullpen_pitches += m.opp_bullpen_picthes.to_i
					team_errors += m.team_errors.to_i
					opp_errors += m.opp_errors.to_i


						

					runs_per_at_bat = (1.0 / (runs_for.to_f / at_bats_for.to_f)).round(2)
					hits_needed_per_run = (hits_for.to_f / runs_for.to_f).round(2)
					runs_per_inning = (runs_for.to_f / innings.to_f).round(2)
					pitches_seen_per_game = ((opp_starter_pitches.to_f + opp_bullpen_pitches.to_f) / innings.to_f).round(2) * 9 
					runs_per_pitch_by_opp = (runs_for.to_f / (opp_starter_pitches.to_f + opp_bullpen_pitches.to_f)).round(3)
					at_bats_per_nine = ((at_bats_for.to_f/innings.to_f) * 9).round(2)
					hits_per_nine = (hits_for.to_f / innings.to_f).round(2) * 9

					runs_against_per_at_bat = (1.0 / (runs_against.to_f / at_bats_against.to_f)).round(2)
					opp_hits_needed_per_run = (hits_against.to_f / runs_against.to_f).round(2)
					opp_runs_per_inning = (runs_against.to_f / innings.to_f).round(2)
					opp_at_bats_per_nine = ((at_bats_against.to_f/innings.to_f).round(2) * 9).round(2)
					opp_hits_per_nine = ((hits_against.to_f / innings.to_f).round(2) * 9).round(2)

					pitches_thrown_per_game = ((starter_pitches.to_f + bullpen_pitches.to_f) / innings.to_f).round(2) * 9
					opp_runs_per_pitch = (runs_against.to_f / pitches_thrown_per_game).round(2)

					starter_freq = ((starter_pitches.to_f / (starter_pitches + bullpen_pitches).to_f) * 100).round(2)
					starter_freq_to_string = starter_freq.to_s + "%"
					bullpen_freq = (100.0 - starter_freq).round(2)
					bullpen_freq_to_string = bullpen_freq.to_s + "%"
					bullpen_rpp = (@bullpen_runs.to_f / bullpen_pitches.to_f).round(3)

					opp_starter_freq = ((opp_starter_pitches.to_f / (opp_starter_pitches + opp_bullpen_pitches).to_f) * 100).round(2)
					opp_bullpen_freq = (100.00 - opp_starter_freq).round(2)
					opp_starter_freq_to_s = opp_starter_freq.to_s + "%"
					opp_bullpen_freq_to_s = opp_bullpen_freq.to_s + "%"


					good_at_bats_per_run = (at_bats_for.to_f - (innings * 3) / runs_for.to_f).round(2)

					opp_good_at_bats_per_run = (at_bats_against.to_f - (innings * 3) / runs_against.to_f).round(2)  

					
					team_stats[:runs_for] = ((runs_for.to_f / innings.to_f) * 9).round(2)
					team_stats[:at_bats_for] = at_bats_for.to_f
					team_stats[:at_bats_per_nine] = at_bats_per_nine.to_f
					team_stats[:runs_per_ab] = runs_per_at_bat.to_f
					team_stats[:hits_per_nine] = hits_per_nine.to_f
					team_stats[:hits_per_run] = hits_needed_per_run.to_f
					team_stats[:runs_per_inning] = runs_per_inning.to_f
					team_stats[:pitches_seen_per_game] = pitches_seen_per_game.to_f
					team_stats[:runs_for_per_pitch] = runs_per_pitch_by_opp
					team_stats[:starter_workload] = starter_freq_to_string
					team_stats[:bullpen_workload] = bullpen_freq_to_string
					team_stats[:opp_starter_workload] = opp_starter_freq_to_s
					team_stats[:opp_bullpen_workload] = opp_bullpen_freq_to_s
					team_stats[:quality_at_bats_per_run] = good_at_bats_per_run
					team_stats[:opp_quality_at_bats_per_run] = opp_good_at_bats_per_run
					
					team_stats[:runs_against] = ((runs_against.to_f / innings.to_f) * 9).round(2)
					team_stats[:at_bats_against] = at_bats_against
					team_stats[:at_bats_against_per_nine] = opp_at_bats_per_nine
					team_stats[:runs_against_per_ab] = runs_against_per_at_bat
					team_stats[:opp_hits_per_nine] = opp_hits_per_nine
					team_stats[:opp_hits_per_run] = opp_hits_needed_per_run
					team_stats[:opp_runs_per_inning] = opp_runs_per_inning
					team_stats[:team_pitches_per_game] = pitches_thrown_per_game
					team_stats[:opp_runs_per_pitch] = opp_runs_per_pitch
					team_stats[:bullpen_runs_per_pitch] = bullpen_rpp

					

				end

				@team_holder.push(team_stats)

			end


		end


	end

	def get_team_rankings_last_thirty

		Team.all.each do |t|

			if t.div_or_conf == "NL East" || t.div_or_conf == "NL Central" || t.div_or_conf == "NL West"

				starter_pitches = 0
				bullpen_pitches = 0
				@bullpen_runs = 0
				runs_for = 0
				runs_against = 0
				hits_for = 0
				hits_against = 0
				at_bats_for = 0
				at_bats_against = 0
				innings = 0
				opp_starter_pitches = 0
				opp_bullpen_pitches = 0
				team_errors = 0
				opp_errors = 0

				team_stats = Hash.new

				team_stats[:team_name] = t.team_name
				team_stats[:runs_for] = 0
				team_stats[:at_bats_for] = 0
				team_stats[:at_bats_per_nine] = 0
				team_stats[:runs_per_ab] = 0
				team_stats[:hits_per_nine] = 0
				team_stats[:hits_per_run] = 0
				team_stats[:runs_per_inning] = 0
				team_stats[:pitches_seen_per_game] = 0
				team_stats[:runs_for_per_pitch] = 0
				team_stats[:starter_workload] = 0
				team_stats[:bullpen_workload] = 0
				team_stats[:opp_starter_workload] = 0
				team_stats[:opp_bullpen_workload] = 0
				team_stats[:quality_at_bats_per_run] = 0
				team_stats[:opp_quality_at_bats_per_run] = 0
				
				team_stats[:runs_against] = 0
				team_stats[:at_bats_against] = 0
				team_stats[:at_bats_against_per_nine] = 0
				team_stats[:runs_against_per_ab] = 0
				team_stats[:opp_hits_per_nine] = 0
				team_stats[:opp_hits_per_run] = 0
				team_stats[:opp_runs_per_inning] = 0
				team_stats[:team_pitches_per_game] = 0
				team_stats[:opp_runs_per_pitch] = 0
				team_stats[:bullpen_runs_per_pitch] = 0




				t.mlb_game_logs.last(30).each do |m|

					starter_pitches += m.team_starter_pitches.to_i
					bullpen_pitches += m.team_bullpen_picthes.to_i
					runs_for += m.team_runs.to_i
					runs_against += m.opp_runs.to_i
					@bullpen_runs += m.runs_by_team_bullpen.to_i
					hits_for += m.team_hits.to_i
					hits_against += m.opp_hits.to_i
					at_bats_for += m.at_bats_for.to_i
					at_bats_against += m.at_bats_against.to_i
					innings += m.innings.to_i
					opp_starter_pitches += m.opp_starter_pitches.to_i
					opp_bullpen_pitches += m.opp_bullpen_picthes.to_i
					team_errors += m.team_errors.to_i
					opp_errors += m.opp_errors.to_i


						

					runs_per_at_bat = (1.0 / (runs_for.to_f / at_bats_for.to_f)).round(2)
					hits_needed_per_run = (hits_for.to_f / runs_for.to_f).round(2)
					runs_per_inning = (runs_for.to_f / innings.to_f).round(2)
					pitches_seen_per_game = ((opp_starter_pitches.to_f + opp_bullpen_pitches.to_f) / innings.to_f).round(2) * 9 
					runs_per_pitch_by_opp = (runs_for.to_f / (opp_starter_pitches.to_f + opp_bullpen_pitches.to_f)).round(3)
					at_bats_per_nine = ((at_bats_for.to_f/innings.to_f) * 9).round(2)
					hits_per_nine = (hits_for.to_f / innings.to_f).round(2) * 9

					runs_against_per_at_bat = (1.0 / (runs_against.to_f / at_bats_against.to_f)).round(2)
					opp_hits_needed_per_run = (hits_against.to_f / runs_against.to_f).round(2)
					opp_runs_per_inning = (runs_against.to_f / innings.to_f).round(2)
					opp_at_bats_per_nine = ((at_bats_against.to_f/innings.to_f).round(2) * 9).round(2)
					opp_hits_per_nine = ((hits_against.to_f / innings.to_f).round(2) * 9).round(2)

					pitches_thrown_per_game = ((starter_pitches.to_f + bullpen_pitches.to_f) / innings.to_f).round(2) * 9
					opp_runs_per_pitch = (runs_against.to_f / pitches_thrown_per_game).round(2)

					starter_freq = ((starter_pitches.to_f / (starter_pitches + bullpen_pitches).to_f) * 100).round(2)
					starter_freq_to_string = starter_freq.to_s + "%"
					bullpen_freq = (100.0 - starter_freq).round(2)
					bullpen_freq_to_string = bullpen_freq.to_s + "%"
					bullpen_rpp = (@bullpen_runs.to_f / bullpen_pitches.to_f).round(3)

					opp_starter_freq = ((opp_starter_pitches.to_f / (opp_starter_pitches + opp_bullpen_pitches).to_f) * 100).round(2)
					opp_bullpen_freq = (100.00 - opp_starter_freq).round(2)
					opp_starter_freq_to_s = opp_starter_freq.to_s + "%"
					opp_bullpen_freq_to_s = opp_bullpen_freq.to_s + "%"


					good_at_bats_per_run = (at_bats_for.to_f - (innings * 3) / runs_for.to_f).round(2)

					opp_good_at_bats_per_run = (at_bats_against.to_f - (innings * 3) / runs_against.to_f).round(2)  

					
					team_stats[:runs_for] = ((runs_for.to_f / innings.to_f) * 9).round(2)
					team_stats[:at_bats_for] = at_bats_for.to_f
					team_stats[:at_bats_per_nine] = at_bats_per_nine.to_f
					team_stats[:runs_per_ab] = runs_per_at_bat.to_f
					team_stats[:hits_per_nine] = hits_per_nine.to_f
					team_stats[:hits_per_run] = hits_needed_per_run.to_f
					team_stats[:runs_per_inning] = runs_per_inning.to_f
					team_stats[:pitches_seen_per_game] = pitches_seen_per_game.to_f
					team_stats[:runs_for_per_pitch] = runs_per_pitch_by_opp
					team_stats[:starter_workload] = starter_freq_to_string
					team_stats[:bullpen_workload] = bullpen_freq_to_string
					team_stats[:opp_starter_workload] = opp_starter_freq_to_s
					team_stats[:opp_bullpen_workload] = opp_bullpen_freq_to_s
					team_stats[:quality_at_bats_per_run] = good_at_bats_per_run
					team_stats[:opp_quality_at_bats_per_run] = opp_good_at_bats_per_run
					
					team_stats[:runs_against] = ((runs_against.to_f / innings.to_f) * 9).round(2)
					team_stats[:at_bats_against] = at_bats_against
					team_stats[:at_bats_against_per_nine] = opp_at_bats_per_nine
					team_stats[:runs_against_per_ab] = runs_against_per_at_bat
					team_stats[:opp_hits_per_nine] = opp_hits_per_nine
					team_stats[:opp_hits_per_run] = opp_hits_needed_per_run
					team_stats[:opp_runs_per_inning] = opp_runs_per_inning
					team_stats[:team_pitches_per_game] = pitches_thrown_per_game
					team_stats[:opp_runs_per_pitch] = opp_runs_per_pitch
					team_stats[:bullpen_runs_per_pitch] = bullpen_rpp

					

				end

				@team_holder.push(team_stats)

			end


		end


	end

	def sort_teams_by_category(team_holder)

		team_runs_for = []
		team_runs_against = []
		team_at_bats_for = []
		team_runs_per_at_bat = []
		team_hits_per_nine = []
		team_hits_per_run = []
		team_pitches_faced_per_game = []
		team_runs_per_pitch = []
		team_bullpen_workload = []
		team_quality_at_bats_per_run = []
		team_bullpen_rpp = []

		team_at_bats_against = []
		team_runs_against_per_ab = []
		team_hits_against_per_nine = []
		team_hits_against_per_run_against = []
		team_starter_workload_against = []
		team_bullpen_workload_against = []



		team_holder.each do |t|

			if t.class == Hash

				team_runs_for.push(t[:runs_for])
				team_runs_against.push(t[:runs_against])
				team_at_bats_for.push(t[:at_bats_per_nine])
				team_at_bats_against.push(t[:at_bats_against_per_nine])
				team_runs_per_at_bat.push(t[:runs_per_ab])
				team_bullpen_rpp.push(t[:bullpen_runs_per_pitch])
				
				team_hits_per_nine.push(t[:hits_per_nine])
				
				team_hits_per_run.push(t[:hits_per_run])
				
				team_pitches_faced_per_game.push(t[:pitches_seen_per_game])
				
				team_runs_per_pitch.push(t[:runs_for_per_pitch])
				
				@team_starter_workload.push(t[:starter_workload].to_f)
				
				team_bullpen_workload.push(t[:bullpen_workload].to_f)
				
				
				team_quality_at_bats_per_run.push(t[:quality_at_bats_per_run])
				
				
				team_runs_against_per_ab.push(t[:runs_against_per_ab])
				
				team_hits_against_per_nine.push(t[:opp_hits_per_nine])
				

				team_hits_against_per_run_against.push(t[:opp_hits_per_run])
				

				team_starter_workload_against.push(t[:opp_starter_workload].to_f)
				team_bullpen_workload_against.push(t[:opp_bullpen_workload].to_f)



			end


		end



		team_runs_for = team_runs_for.sort
		team_runs_for = team_runs_for.reverse
		team_runs_against = team_runs_against.sort
		team_at_bats_for = team_at_bats_for.sort
		team_at_bats_for = team_at_bats_for.reverse
		team_at_bats_against = team_at_bats_against.sort
		team_runs_per_at_bat = team_runs_per_at_bat.sort
		team_hits_per_nine = team_hits_per_nine.sort
		team_hits_per_nine = team_hits_per_nine.reverse
		team_hits_per_run = team_hits_per_run.sort
		team_pitches_faced_per_game = team_pitches_faced_per_game.sort
		team_pitches_faced_per_game = team_pitches_faced_per_game.reverse
		team_runs_per_pitch = team_runs_per_pitch.sort
		team_runs_per_pitch = team_runs_per_pitch.reverse
		team_bullpen_rpp = team_bullpen_rpp.sort
		@team_starter_workload = @team_starter_workload.sort
		@team_starter_workload = @team_starter_workload.reverse
		team_bullpen_workload = team_bullpen_workload.sort
		team_quality_at_bats_per_run = team_quality_at_bats_per_run.sort
		team_at_bats_against = team_at_bats_against.sort
		team_runs_against_per_ab = team_runs_against_per_ab.sort
		team_runs_against_per_ab = team_runs_against_per_ab.reverse
		team_hits_against_per_nine = team_hits_against_per_nine.sort
		team_hits_against_per_run_against = team_hits_against_per_run_against.sort
		team_hits_against_per_run_against = team_hits_against_per_run_against.reverse
		team_starter_workload_against = team_starter_workload_against.sort
		team_bullpen_workload_against = team_bullpen_workload_against.sort
		team_bullpen_workload_against = team_bullpen_workload_against.reverse
		


		team_runs_for.each do |r|

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:runs_for]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:runs_for] = t[:runs_for]
						@runs_for_standings.push(team_data) unless @runs_for_standings.include?(team_data)

					end


				end

			end


		end

		team_runs_against.each do |r|

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:runs_against]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:runs_against] = t[:runs_against]
						@runs_against_standings.push(team_data) unless @runs_against_standings.include?(team_data)

					end


				end

			end


		end

		team_at_bats_for.each do |r|

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:at_bats_per_nine]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:at_bats_for] = t[:at_bats_per_nine]
						@at_bats_for_standings.push(team_data) unless @at_bats_for_standings.include?(team_data)

					end


				end

			end



		end

		team_bullpen_rpp.each do |r|

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:bullpen_runs_per_pitch]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:bullpen_rpp] = (1.0/t[:bullpen_runs_per_pitch]).round(2)
						@bullpen_rpp_standings.push(team_data) unless @bullpen_rpp_standings.include?(team_data)


					end


				end

			end



		end

		team_at_bats_against.each do |r|

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:at_bats_against_per_nine]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:at_bats_against] = t[:at_bats_against_per_nine]
						@at_bats_against_standings.push(team_data) unless @at_bats_against_standings.include?(team_data)

					end

				end

			end

		end

		team_runs_per_at_bat.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:runs_per_ab]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:runs_per_ab] = t[:runs_per_ab]
						@runs_per_at_bat_standings.push(team_data) unless @runs_per_at_bat_standings.include?(team_data)

					end

				end

			end

		end

		team_hits_per_nine.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:hits_per_nine]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:hits_per_nine] = t[:hits_per_nine]
						@hits_per_nine_standings.push(team_data) unless @hits_per_nine_standings.include?(team_data)

					end

				end

			end

		end

		team_hits_per_run.push.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:hits_per_run]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:hits_per_run] = t[:hits_per_run]
						@hits_per_run_standings.push(team_data) unless @hits_per_run_standings.include?(team_data)

					end

				end

			end

		end

		team_pitches_faced_per_game.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:pitches_seen_per_game]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:pitches_seen_per_game] = t[:pitches_seen_per_game]
						@pitches_faced_standings.push(team_data) unless @pitches_faced_standings.include?(team_data)

					end

				end

			end

		end

		team_runs_per_pitch.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:runs_for_per_pitch]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:runs_for_per_pitch] = t[:runs_for_per_pitch]
						@runs_per_pitch_standings.push(team_data) unless @runs_per_pitch_standings.include?(team_data)

					end

				end

			end

		end

		@team_starter_workload.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:starter_workload].to_f

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:starter_workload] = t[:starter_workload].to_s 
						@starter_workload_standings.push(team_data) unless @starter_workload_standings.include?(team_data)

					end

				end

			end

		end

		team_bullpen_workload.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:bullpen_workload].to_f

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:bullpen_workload] = t[:bullpen_workload].to_s 
						@bullpen_workload_standings.push(team_data) unless @bullpen_workload_standings.include?(team_data)

					end

				end

			end

		end



		team_runs_against_per_ab.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:runs_against_per_ab]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:runs_against_per_ab] = t[:runs_against_per_ab]
						@runs_against_per_ab_standings.push(team_data) unless @runs_against_per_ab_standings.include?(team_data)

					end

				end

			end

		end

		team_hits_against_per_nine.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:opp_hits_per_nine]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:opp_hits_per_nine] = t[:opp_hits_per_nine]
						@hits_against_per_nine_standings.push(team_data) unless @hits_against_per_nine_standings.include?(team_data)

					end

				end

			end

		end

		team_hits_against_per_run_against.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:opp_hits_per_run]

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:opp_hits_per_run] = t[:opp_hits_per_run]
						@hits_against_per_run_against_standings.push(team_data) unless @hits_against_per_run_against_standings.include?(team_data)

					end

				end

			end

		end

		team_starter_workload_against.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:opp_starter_workload].to_f

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:opp_starter_workload] = t[:opp_starter_workload].to_s 
						@starter_workload_against_standings.push(team_data) unless @starter_workload_against_standings.include?(team_data)

					end

				end

			end

		end

		team_bullpen_workload_against.each do |r| 

			team_holder.each do |t|

				if t.class == Hash

					if r == t[:opp_bullpen_workload].to_f

						team_data = Hash.new
						team_data[:team] = t[:team_name]
						team_data[:opp_bullpen_workload] = t[:opp_bullpen_workload].to_s 
						@bullpen_workload_against_standings.push(team_data) unless @bullpen_workload_against_standings.include?(team_data)

					end

				end

			end

		end

	end

	def get_picks

		Pick.all.each do |p|

			if p.reason.downcase == "c/r"

				if p.result == "win"

					@cr_wins += 1

					if p.cat == "total"

						@cr_total_wins +=1

					else

						@cr_side_wins +=1

					end

				elsif p.result == "loss"

					@cr_losses +=1

					if p.cat == "total"

						@cr_total_losses +=1

					else

						@cr_side_losses +=1

					end

				end

			end


		end

	end

	def get_matchup_rankings
		
		fav_plays = 0
		dog_plays = 0

		fav_plays_ag = 0
		dog_plays_ag = 0

		fav_runs = 0
		dog_runs = 0

		fav_pass = 0
		dog_pass = 0

		fav_runs_ag = 0
		dog_runs_ag = 0

		fav_pass_ag = 0
		dog_pass_ag = 0

		fav_rush_for = 0
		dog_rush_for = 0

		fav_rush_ag = 0
		dog_rush_ag = 0

		fav_rush_pos = 0
		dog_rush_pos = 0

		fav_rush_ag_pos = 0
		dog_rush_ag_pos = 0

		fav_pass_for = 0
		dog_pass_for = 0

		fav_pass_ag = 0
		dog_pass_ag = 0

		fav_pass_pos = 0
		dog_pass_pos = 0

		fav_pass_ag_pos = 0
		dog_pass_ag_pos = 0

		fav_plays_for = 0
		dog_plays_for = 0

		fav_plays_for_pos = 0
		dog_plays_for_pos = 0

		fav_plays_ag = 0
		dog_plays_ag = 0

		fav_plays_ag_pos = 0
		dog_plays_ag_pos = 0

		fav_pl_min = 0
		dog_pl_min = 0

		fav_pl_min_pos = 0
		dog_pl_min_pos = 0

		fav_sacks_for = 0
		dog_sacks_for = 0

		fav_sacks_for_pos = 0
		dog_sacks_for_pos = 0

		fav_sacks_ag = 0
		dog_sacks_ag = 0

		fav_sacks_ag_pos = 0
		dog_sacks_ag_pos = 0

		fav_sc_pl_for = 0
		dog_sc_pl_for = 0

		fav_sc_pl_for_pos = 0
		dog_sc_pl_for_pos = 0

		fav_sc_pl_ag = 0
		dog_sc_pl_ag = 0

		fav_sc_pl_ag_pos = 0
		dog_sc_pl_ag_pos = 0

		fav_score_diff = 0
		dog_score_diff = 0

		fav_score_diff_pos = 0
		dog_score_diff_pos = 0

		fav_ats_record = 0
		dog_ats_record = 0

		@record.each do |p|

			if p[:id].to_i == @nfl_fav.id

				@fav_record = p[:record]

			elsif p[:id].to_i == @nfl_dog.id

				@dog_record = p[:record]

			end


		end
		
		@plays_for.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_plays = p[:plays_per_game]

			elsif p[:id].to_i == @nfl_dog.id

				dog_plays = p[:plays_per_game]

			end


		end

		@plays_ag.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_plays_ag = p[:plays_ag_per_game]

			elsif p[:id].to_i == @nfl_dog.id

				dog_plays_ag = p[:plays_ag_per_game]

			end


		end

		@run_pl_for.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_runs = p[:run_plays_per_game]

			elsif p[:id].to_i == @nfl_dog.id

				dog_runs = p[:run_plays_per_game]

			end



		end

		@run_pl_ag.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_runs_ag = p[:run_plays_ag_per_game]

			elsif p[:id].to_i == @nfl_dog.id

				dog_runs_ag = p[:run_plays_ag_per_game]

			end



		end

		@pass_pl_for.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_pass = p[:pass_plays_per_game]

			elsif p[:id].to_i == @nfl_dog.id

				dog_pass = p[:pass_plays_per_game]

			end



		end

		@pass_pl_ag.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_pass_ag = p[:pass_plays_ag_per_game]

			elsif p[:id].to_i == @nfl_dog.id

				dog_pass_ag = p[:pass_plays_ag_per_game]

			end

		end

		@rush_for.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_rush_for = p[:rush_yards_per]
				fav_rush_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_rush_for = p[:rush_yards_per]
				dog_rush_pos = p[:position].to_i

			end

		end

		@rush_ag.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_rush_ag = p[:rush_yards_ag_per]
				fav_rush_ag_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_rush_ag = p[:rush_yards_ag_per]
				dog_rush_ag_pos = p[:position].to_i

			end

		end

		@pass_ag.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_pass_ag = p[:pass_yards_ag_per]
				fav_pass_ag_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_pass_ag = p[:pass_yards_ag_per]
				dog_pass_ag_pos = p[:position].to_i

			end

		end

		@pass_for.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_pass_for = p[:pass_yards_per]
				fav_pass_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_pass_for = p[:pass_yards_per]
				dog_pass_pos = p[:position].to_i

			end

		end

		@plays_for.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_plays_for = p[:plays_per_game]
				fav_plays_for_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_plays_for = p[:plays_per_game]
				dog_plays_for_pos = p[:position].to_i

			end


		end

		@plays_ag.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_plays_ag = p[:plays_ag_per_game]
				fav_plays_ag_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_plays_ag = p[:plays_ag_per_game]
				dog_plays_ag_pos = p[:position].to_i

			end


		end

		@pl_min.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_pl_min = p[:plus_minus]
				fav_pl_min_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_pl_min = p[:plus_minus]
				dog_pl_min_pos = p[:position].to_i

			end


		end

		@sacks_for.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_sacks_for = p[:sacks_per_game]
				fav_sacks_for_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_sacks_for = p[:sacks_per_game]
				dog_sacks_for_pos = p[:position].to_i

			end


		end

		@sacks_ag.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_sacks_ag = p[:sacks_ag_per_game]
				fav_sacks_ag_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_sacks_ag = p[:sacks_ag_per_game]
				dog_sacks_ag_pos = p[:position].to_i

			end


		end

		@sc_pl_for.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_sc_pl_for = p[:scoring_plays_per_game]
				fav_sc_pl_for_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_sc_pl_for = p[:scoring_plays_per_game]
				dog_sc_pl_for_pos = p[:position].to_i

			end


		end

		@sc_pl_ag.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_sc_pl_ag = p[:scoring_plays_ag_per_game]
				fav_sc_pl_ag_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_sc_pl_ag = p[:scoring_plays_ag_per_game]
				dog_sc_pl_ag_pos = p[:position].to_i

			end


		end

		@score_diff.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_score_diff = p[:scoring_diff]
				fav_score_diff_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_score_diff = p[:scoring_diff]
				dog_score_diff_pos = p[:position].to_i

			end


		end

		@record.each do |p|

			if p[:id].to_i == @nfl_fav.id

				fav_ats_record = p[:record]
				fav_ats_record_pos = p[:position].to_i

			elsif p[:id].to_i == @nfl_dog.id

				dog_ats_record = p[:record]
				dog_ats_record_pos = p[:position].to_i

			end


		end

		@fav_run_percentage = ((fav_runs.to_f / fav_plays.to_f) * 100).round(2)
		@dog_run_percentage = ((dog_runs.to_f / dog_plays.to_f) * 100).round(2)

		@fav_pass_percentage = ((fav_pass.to_f / fav_plays.to_f) * 100).round(2)
		@dog_pass_percentage = ((dog_pass.to_f / dog_plays.to_f) * 100).round(2)

		@fav_run_ag_percentage = ((fav_runs_ag.to_f / fav_plays_ag.to_f) * 100).round(2)
		@dog_run_ag_percentage = ((dog_runs_ag.to_f / dog_plays_ag.to_f) * 100).round(2)

		@fav_pass_ag_percentage = ((fav_pass_ag.to_f / fav_plays_ag.to_f) * 100).round(2)
		@dog_pass_ag_percentage = ((dog_pass_ag.to_f / dog_plays_ag.to_f) * 100).round(2)

		@fav_rush_for = fav_rush_for
		@dog_rush_for = dog_rush_for

		@fav_rush_pos = fav_rush_pos
		@dog_rush_pos = dog_rush_pos

		@fav_rush_ag = fav_rush_ag
		@dog_rush_ag = dog_rush_ag

		@fav_rush_ag_pos = fav_rush_ag_pos
		@dog_rush_ag_pos = dog_rush_ag_pos

		@fav_pass_for = fav_pass_for
		@dog_pass_for = dog_pass_for

		@fav_pass_pos = fav_pass_pos
		@dog_pass_pos = dog_pass_pos

		@fav_pass_ag = fav_pass_ag
		@dog_pass_ag = dog_pass_ag

		@fav_pass_ag_pos = fav_pass_ag_pos
		@dog_pass_ag_pos = dog_pass_ag_pos

		@dog_plays_for = dog_plays_for
		@fav_plays_for = fav_plays_for

		@fav_plays_for_pos = fav_plays_for_pos
		@dog_plays_for_pos = dog_plays_for_pos

		@dog_plays_ag = dog_plays_ag
		@fav_plays_ag = fav_plays_ag

		@fav_plays_ag_pos = fav_plays_ag_pos
		@dog_plays_ag_pos = dog_plays_ag_pos

		@fav_pl_min = fav_pl_min
		@dog_pl_min = dog_pl_min

		@fav_pl_min_pos = fav_pl_min_pos
		@dog_pl_min_pos = dog_pl_min_pos

		@fav_sacks_for = fav_sacks_for
		@dog_sacks_for = dog_sacks_for

		@fav_sacks_for_pos = fav_sacks_for_pos
		@dog_sacks_for_pos = dog_sacks_for_pos

		@fav_sacks_ag = fav_sacks_ag
		@dog_sacks_ag = dog_sacks_ag

		@fav_sacks_ag_pos = fav_sacks_ag_pos
		@dog_sacks_ag_pos = dog_sacks_ag_pos

		@fav_sc_pl_for = fav_sc_pl_for
		@dog_sc_pl_for = dog_sc_pl_for

		@fav_sc_pl_for_pos = fav_sc_pl_for_pos
		@dog_sc_pl_for_pos = dog_sc_pl_for_pos

		@fav_sc_pl_ag = fav_sc_pl_ag
		@dog_sc_pl_ag = dog_sc_pl_ag

		@fav_sc_pl_ag_pos = fav_sc_pl_ag_pos
		@dog_sc_pl_ag_pos = dog_sc_pl_ag_pos

		@fav_score_diff = fav_score_diff
		@dog_score_diff = dog_score_diff

		@fav_score_diff_pos = fav_score_diff_pos
		@dog_score_diff_pos = dog_score_diff_pos

		@fav_ats_record = fav_ats_record
		@dog_ats_record = dog_ats_record

	end

	def get_cfb_matchup_rankings
		
		fav_plays = 0
		dog_plays = 0

		fav_plays_ag = 0
		dog_plays_ag = 0

		fav_runs = 0
		dog_runs = 0

		fav_pass = 0
		dog_pass = 0

		fav_runs_ag = 0
		dog_runs_ag = 0

		fav_pass_ag = 0
		dog_pass_ag = 0

		fav_rush_for = 0
		dog_rush_for = 0

		fav_rush_ag = 0
		dog_rush_ag = 0

		fav_rush_pos = 0
		dog_rush_pos = 0

		fav_rush_ag_pos = 0
		dog_rush_ag_pos = 0

		fav_pass_for = 0
		dog_pass_for = 0

		fav_pass_ag = 0
		dog_pass_ag = 0

		fav_pass_pos = 0
		dog_pass_pos = 0

		fav_pass_ag_pos = 0
		dog_pass_ag_pos = 0

		fav_plays_for = 0
		dog_plays_for = 0

		fav_plays_for_pos = 0
		dog_plays_for_pos = 0

		fav_plays_ag = 0
		dog_plays_ag = 0

		fav_plays_ag_pos = 0
		dog_plays_ag_pos = 0

		fav_pl_min = 0
		dog_pl_min = 0

		fav_pl_min_pos = 0
		dog_pl_min_pos = 0

		fav_sacks_for = 0
		dog_sacks_for = 0

		fav_sacks_for_pos = 0
		dog_sacks_for_pos = 0

		fav_sacks_ag = 0
		dog_sacks_ag = 0

		fav_sacks_ag_pos = 0
		dog_sacks_ag_pos = 0

		fav_sc_pl_for = 0
		dog_sc_pl_for = 0

		fav_sc_pl_for_pos = 0
		dog_sc_pl_for_pos = 0

		fav_sc_pl_ag = 0
		dog_sc_pl_ag = 0

		fav_sc_pl_ag_pos = 0
		dog_sc_pl_ag_pos = 0

		fav_score_diff = 0
		dog_score_diff = 0

		fav_score_diff_pos = 0
		dog_score_diff_pos = 0

		fav_ats_record = 0
		dog_ats_record = 0

		@record.each do |p|

			if p[:id].to_i == @cfb_fav.id

				@fav_record = p[:record]

			elsif p[:id].to_i == @cfb_dog.id

				@dog_record = p[:record]

			end


		end
		
		@plays_for.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_plays = p[:plays_per_game]

			elsif p[:id].to_i == @cfb_dog.id

				dog_plays = p[:plays_per_game]

			end


		end

		@plays_ag.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_plays_ag = p[:plays_ag_per_game]

			elsif p[:id].to_i == @cfb_dog.id

				dog_plays_ag = p[:plays_ag_per_game]

			end


		end

		@run_pl_for.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_runs = p[:run_plays_per_game]

			elsif p[:id].to_i == @cfb_dog.id

				dog_runs = p[:run_plays_per_game]

			end



		end

		@run_pl_ag.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_runs_ag = p[:run_plays_ag_per_game]

			elsif p[:id].to_i == @cfb_dog.id

				dog_runs_ag = p[:run_plays_ag_per_game]

			end



		end

		@pass_pl_for.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_pass = p[:pass_plays_per_game]

			elsif p[:id].to_i == @cfb_dog.id

				dog_pass = p[:pass_plays_per_game]

			end



		end

		@pass_pl_ag.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_pass_ag = p[:pass_plays_ag_per_game]

			elsif p[:id].to_i == @cfb_dog.id

				dog_pass_ag = p[:pass_plays_ag_per_game]

			end

		end

		@rush_for.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_rush_for = p[:rush_yards_per]
				fav_rush_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_rush_for = p[:rush_yards_per]
				dog_rush_pos = p[:position].to_i

			end

		end

		@rush_ag.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_rush_ag = p[:rush_yards_ag_per]
				fav_rush_ag_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_rush_ag = p[:rush_yards_ag_per]
				dog_rush_ag_pos = p[:position].to_i

			end

		end

		@pass_ag.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_pass_ag = p[:pass_yards_ag_per]
				fav_pass_ag_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_pass_ag = p[:pass_yards_ag_per]
				dog_pass_ag_pos = p[:position].to_i

			end

		end

		@pass_for.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_pass_for = p[:pass_yards_per]
				fav_pass_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_pass_for = p[:pass_yards_per]
				dog_pass_pos = p[:position].to_i

			end

		end

		@plays_for.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_plays_for = p[:plays_per_game]
				fav_plays_for_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_plays_for = p[:plays_per_game]
				dog_plays_for_pos = p[:position].to_i

			end


		end

		@plays_ag.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_plays_ag = p[:plays_ag_per_game]
				fav_plays_ag_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_plays_ag = p[:plays_ag_per_game]
				dog_plays_ag_pos = p[:position].to_i

			end


		end

		@pl_min.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_pl_min = p[:plus_minus]
				fav_pl_min_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_pl_min = p[:plus_minus]
				dog_pl_min_pos = p[:position].to_i

			end


		end

		@sacks_for.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_sacks_for = p[:sacks_per_game]
				fav_sacks_for_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_sacks_for = p[:sacks_per_game]
				dog_sacks_for_pos = p[:position].to_i

			end


		end

		@sacks_ag.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_sacks_ag = p[:sacks_ag_per_game]
				fav_sacks_ag_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_sacks_ag = p[:sacks_ag_per_game]
				dog_sacks_ag_pos = p[:position].to_i

			end


		end

		@sc_pl_for.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_sc_pl_for = p[:scoring_plays_per_game]
				fav_sc_pl_for_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_sc_pl_for = p[:scoring_plays_per_game]
				dog_sc_pl_for_pos = p[:position].to_i

			end


		end

		@sc_pl_ag.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_sc_pl_ag = p[:scoring_plays_ag_per_game]
				fav_sc_pl_ag_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_sc_pl_ag = p[:scoring_plays_ag_per_game]
				dog_sc_pl_ag_pos = p[:position].to_i

			end


		end

		@score_diff.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_score_diff = p[:scoring_diff]
				fav_score_diff_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_score_diff = p[:scoring_diff]
				dog_score_diff_pos = p[:position].to_i

			end


		end

		@record.each do |p|

			if p[:id].to_i == @cfb_fav.id

				fav_ats_record = p[:record]
				fav_ats_record_pos = p[:position].to_i

			elsif p[:id].to_i == @cfb_dog.id

				dog_ats_record = p[:record]
				dog_ats_record_pos = p[:position].to_i

			end


		end

		

		@fav_rush_for = fav_rush_for
		@dog_rush_for = dog_rush_for

		@fav_rush_pos = fav_rush_pos
		@dog_rush_pos = dog_rush_pos

		@fav_rush_ag = fav_rush_ag
		@dog_rush_ag = dog_rush_ag

		@fav_rush_ag_pos = fav_rush_ag_pos
		@dog_rush_ag_pos = dog_rush_ag_pos

		@fav_pass_for = fav_pass_for
		@dog_pass_for = dog_pass_for

		@fav_pass_pos = fav_pass_pos
		@dog_pass_pos = dog_pass_pos

		@fav_pass_ag = fav_pass_ag
		@dog_pass_ag = dog_pass_ag

		@fav_pass_ag_pos = fav_pass_ag_pos
		@dog_pass_ag_pos = dog_pass_ag_pos

		@dog_plays_for = dog_plays_for
		@fav_plays_for = fav_plays_for

		@fav_plays_for_pos = fav_plays_for_pos
		@dog_plays_for_pos = dog_plays_for_pos

		@dog_plays_ag = dog_plays_ag
		@fav_plays_ag = fav_plays_ag

		@fav_plays_ag_pos = fav_plays_ag_pos
		@dog_plays_ag_pos = dog_plays_ag_pos

		@fav_pl_min = fav_pl_min
		@dog_pl_min = dog_pl_min

		@fav_pl_min_pos = fav_pl_min_pos
		@dog_pl_min_pos = dog_pl_min_pos

		@fav_sacks_for = fav_sacks_for
		@dog_sacks_for = dog_sacks_for

		@fav_sacks_for_pos = fav_sacks_for_pos
		@dog_sacks_for_pos = dog_sacks_for_pos

		@fav_sacks_ag = fav_sacks_ag
		@dog_sacks_ag = dog_sacks_ag

		@fav_sacks_ag_pos = fav_sacks_ag_pos
		@dog_sacks_ag_pos = dog_sacks_ag_pos

		@fav_sc_pl_for = fav_sc_pl_for
		@dog_sc_pl_for = dog_sc_pl_for

		@fav_sc_pl_for_pos = fav_sc_pl_for_pos
		@dog_sc_pl_for_pos = dog_sc_pl_for_pos

		@fav_sc_pl_ag = fav_sc_pl_ag
		@dog_sc_pl_ag = dog_sc_pl_ag

		@fav_sc_pl_ag_pos = fav_sc_pl_ag_pos
		@dog_sc_pl_ag_pos = dog_sc_pl_ag_pos

		@fav_score_diff = fav_score_diff
		@dog_score_diff = dog_score_diff

		@fav_score_diff_pos = fav_score_diff_pos
		@dog_score_diff_pos = dog_score_diff_pos

		@fav_ats_record = fav_ats_record
		@dog_ats_record = dog_ats_record

	end

end
