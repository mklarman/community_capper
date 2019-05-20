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

	def get_pitches_needed(team_obj)

		@team_pitches_per_nine

		@pitches = 0
		@innings = 0

		MlbGameLog.all.each do |m|

			if m.team_id.to_i == team_obj.id

				@pitches = @pitches + m.team_starter_pitches.to_i + m.team_bullpen_picthes.to_i
				@innings += m.innings.to_i

			end

		end

		@pitches = @pitches.to_f/@innings.to_f
		@team_pitches_per_nine = @pitches.to_f * 9

	end

	def get_pitches_forced(team_obj)

		@opp_pitches_per_nine

		@pitches = 0
		@innings = 0

		MlbGameLog.all.each do |m|

			if m.team_id.to_i == team_obj.id

				@pitches = @pitches + m.opp_starter_pitches.to_i + m.opp_bullpen_picthes.to_i
				@innings += m.innings.to_i

			end

		end

		@pitches = @pitches.to_f/@innings.to_f
		@opp_pitches_per_nine = @pitches.to_f * 9

	end

	def get_runs_scored_per_pitch(team_obj)

		@runs_per_pitch

		@runs = 0
		@pitches = 0

		MlbGameLog.all.each do |m|

			if m.team_id.to_i == team_obj.id

				@runs += m.team_runs.to_i
				@pitches += m.team_starter_pitches.to_i
				@pitches += m.team_bullpen_picthes.to_i

			end


		end

		@runs_per_pitch = @runs.to_f/@pitches.to_f



	end

	def get_at_bats_per_nine(team_obj)

		@at_bats_per_nine

		@at_bats = 0
		@innings = 0

		MlbGameLog.all.each do |m|

			if m.team_id.to_i == team_obj.id

				@at_bats += m.at_bats_for.to_i
				@innings += m.innings.to_i

			end


		end

		@at_bats = @at_bats.to_f/@innings.to_f

		@at_bats_per_nine = @at_bats * 9.0


	end

	def get_at_bats_against_per_nine


		@at_bats_against_per_nine

		@at_bats = 0
		@innings = 0

		MlbGameLog.all.each do |m|

			if m.team_id.to_i == team_obj.id

				@at_bats += m.at_bats_against.to_i
				@innings += m.innings.to_i

			end


		end

		@at_bats = @at_bats.to_f/@innings.to_f

		@at_bats_against_per_nine = @at_bats * 9.0

	end

	def get_team_rankings

		Team.all.each do |t|

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

				if t.id == m.team_id.to_i

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
						

					runs_per_at_bat = (runs_for.to_f / at_bats_for.to_f).round(2)
					hits_needed_per_run = (hits_for.to_f / runs_for.to_f).round(2)
					runs_per_inning = (runs_for.to_f / innings.to_f).round(2)
					pitches_seen_per_game = ((opp_starter_pitches.to_f + opp_bullpen_pitches.to_f) / innings.to_f).round(2) * 9 
					runs_per_pitch_by_opp = (runs_for.to_f / pitches_seen_per_game).round(2)
					at_bats_per_nine = (at_bats_for.to_f/innings.to_f).round(2) * 9
					hits_per_nine = (hits_for.to_f / innings.to_f).round(2) * 9

					runs_against_per_at_bat = (runs_against.to_f / at_bats_against.to_f).round(2)
					opp_hits_needed_per_run = (hits_against.to_f / runs_against.to_f).round(2)
					opp_runs_per_inning = (runs_against.to_f / innings.to_f).round(2)
					opp_at_bats_per_nine = (at_bats_against.to_f/innings.to_f).round(2) * 9
					opp_hits_per_nine = (hits_against.to_f / innings.to_f).round(2) * 9

					pitches_thrown_per_game = ((starter_pitches.to_f + bullpen_pitches.to_f) / innings.to_f).round(2) * 9
					opp_runs_per_pitch = (runs_against.to_f / pitches_thrown_per_game).round(2)



					team_stats = Hash.new

					team_stats[:team_name] = m.team_name
					team_stats[:runs_for] = runs_for.to_f
					team_stats[:at_bats_for] = at_bats_for.to_f
					team_stats[:at_bats_per_nine] = at_bats_per_nine
					team_stats[:runs_per_ab] = runs_per_at_bat
					team_stats[:hits_per_nine] = hits_per_nine
					team_stats[:hits_per_run] = hits_needed_per_run
					team_stats[:runs_per_inning] = runs_per_inning
					team_stats[:pitches_seen_per] = pitches_seen_per_game
					team_stats[:runs_for_per_pitch] = runs_per_pitch_by_opp
					
					team_stats[:runs_against] = runs_against
					team_stats[:at_bats_against] = at_bats_against
					team_stats[:at_bats_against_per_nine] = opp_at_bats_per_nine
					team_stats[:runs_against_per_ab] = runs_against_per_at_bat
					team_stats[:opp_hits_per_nine] = opp_hits_per_nine
					team_stats[:opp_hits_per_run] = opp_hits_needed_per_run
					team_stats[:opp_runs_per_inning] = opp_runs_per_inning
					team_stats[:team_pitches_per_game] = pitches_thrown_per_game
					team_stats[:opp_runs_per_pitch] = opp_runs_per_pitch

					@team_holder.push(team_stats)

				end

			end


		end


	end

end
