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

		@home_amv = score_holder.inject(0){|sum,x| sum + x }

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

		@road_amv = score_holder.inject(0){|sum,x| sum + x }

	end
end
