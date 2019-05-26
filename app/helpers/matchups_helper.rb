module MatchupsHelper

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

	def define_home_away

		Team.all.each do |t|

			if @matchup.fav == t.matchup_abbr

				if @matchup.fav_field == "home"

					@home_team = t


				else

					if @matchup.fav_field == "away"

						@road_team = t

					end


				end


			end

			if @matchup.dog == t.matchup_abbr

				if @matchup.dog_field == "home"


					@home_team = t

				else

					@road_team = t


				end

			end

		end


	end

	def get_home_game_logs(team_id)

		MlbGameLog.all.each do |m|

			if m.team_id.to_i == team_id.to_i

				@home_game_logs.push(m)

			end

		end

	end

	def get_away_game_logs(team_id)

		MlbGameLog.all.each do |m|

			if m.team_id.to_i == team_id.to_i

				@away_game_logs.push(m)

			end

		end

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

	def compute_home_vs_team

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

		@home_game_logs.each do |m|

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

		@home_runs_per_game = ((@runs_for.to_f / @innings.to_f) * 9).round(2)


	end
end
