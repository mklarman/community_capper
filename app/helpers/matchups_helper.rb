module MatchupsHelper

	def get_last_sport

		if current_user.picks.length > 0

			if current_user.picks.last.date == @my_date

				if current_user.picks.last.sport == "NFL"

					@nfl_last = true
					@nba_last = false
					@mlb_last = false


				elsif current_user.picks.last.sport == "NBA"

					@nfl_last = false
					@nba_last = true
					@mlb_last = false
				

				elsif current_user.picks.last.sport == "MLB"

					@nfl_last = false
					@nba_last = false
					@mlb_last = true

				end

			end


		end


	end

	def get_spread_tag

		if @matchup.sport == "MLB"

			if (@matchup.fav_ml.to_i).abs < 130

				@fav_line = "low"

			elsif (@matchup.fav_ml.to_i).abs >= 130 && (@matchup.fav_ml.to_f).abs < 160

				@fav_line = "med"
			
			elsif (@matchup.fav_ml.to_i).abs >= 160

				@fav_line = "hi"

			end

			if (@matchup.dog_ml.to_i).abs < 130

				@dog_line = "low"

			elsif (@matchup.dog_ml.to_i).abs >= 130 && (@matchup.dog_ml.to_f).abs < 160

				@dog_line = "med"
			
			elsif (@matchup.dog_ml.to_i).abs >= 160

				@dog_line = "hi"

			end

		elsif @matchup.sport == "NFL"

			if (@matchup.spread.to_f).abs < 4

				@spread_line = "low"

			elsif (@matchup.spread.to_f).abs >= 4 && (@matchup.spread.to_f).abs < 8

				@spread_line = "med"
			
			elsif (@matchup.spread.to_f).abs >= 8

				@spread_line = "hi"

			end
		
		elsif @matchup.sport == "NBA"

			if (@matchup.spread.to_f).abs < 4

				@spread_line = "low"

			elsif (@matchup.spread.to_f).abs >= 4 && (@matchup.spread.to_f).abs < 8

				@spread_line = "med"
			
			elsif (@matchup.spread.to_f).abs >= 8

				@spread_line = "hi"

			end

		end

		if @matchup.sport == "MLB"

			if @matchup.total.to_f < 8

				@total_line = "low"


			elsif @matchup.total.to_f >= 8 && @matchup.total.to_f < 10

				@total_line = "med"

			elsif @matchup.total.to_f >= 10

				@total_line = "hi"


			end


		elsif @matchup.sport == "NFL"

			if @matchup.total.to_f < 48

				@total_line = "low"


			elsif @matchup.total.to_f >= 48 && @matchup.total.to_f < 53

				@total_line = "med"

			elsif @matchup.total.to_f >= 53

				@total_line = "hi"


			end

		elsif @matchup.sport == "NBA"

			if @matchup.total.to_f < 220

				@total_line = "low"


			elsif @matchup.total.to_f >= 220 && @matchup.total.to_f < 228

				@total_line = "med"

			elsif @matchup.total.to_f >= 228

				@total_line = "hi"


			end


		end

	end

	def check_user_picks

		@pick_obj

		if current_user.picks.length > 0

			current_user.picks.each do |p|

				@pick_obj = {}

				if p.date == @my_date

					if p.sport == "NFL"

						@pick_obj[:matchup_id] = p.matchup_id
						@pick_obj[:bet_type] = p.bet_type
						@pick_obj[:date] = p.date

						@user_nfl_picks.push(@pick_obj)

					end

					if p.sport == "NBA"

						@pick_obj[:matchup_id] = p.matchup_id
						@pick_obj[:bet_type] = p.bet_type
						@pick_obj[:date] = p.date

						@user_nba_picks.push(@pick_obj)

					end

					if p.sport == "MLB"

						@pick_obj[:matchup_id] = p.matchup_id
						@pick_obj[:bet_type] = p.bet_type
						@pick_obj[:date] = p.date

						@user_mlb_picks.push(@pick_obj)

					end

				end
			end

		end

		@user_nfl_picks = @user_nfl_picks.uniq
		@user_nba_picks = @user_nba_picks.uniq
		@user_mlb_picks = @user_mlb_picks.uniq




	end

	def get_user_picks

		if current_user.picks.length != 0

			current_user.picks.all.each do |p|

				if p.date == @my_date

				@all_user_picks.push(p)


				end

			end



		end

	end

	def sort_matchups

		Matchup.all.each do |m|

			if m.date == @my_date && m.home_score.length == 0

				if m.sport == "NFL"

					@nfl_matchups.push(m)

				elsif m.sport == "NBA"

					@nba_matchups.push(m)
				
				elsif m.sport == "MLB"

					@mlb_matchups.push(m)

				end


			end

		end

	end

	def list_matchups_for_update

		Matchup.all.each do |m|

			if m.home_score.length == 0

				if m.sport == "NFL"

					@nfl_update.push(m)

				elsif m.sport == "NBA"

					@nba_update.push(m)
				
				elsif m.sport == "MLB"

					@mlb_update.push(m)


				end



			end


		end

	end

	def sort_picks_for_matchup

		if @matchup.picks

			@matchup.picks.each do |p|

				consensus_info = {}

				consensus_info[:user_id] = p.user_id

				team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

				if team == @matchup.fav

					consensus_info[:pick] = @matchup.fav

					consensus_info[:location] = @matchup.fav_field


					if @matchup.sport.upcase == "MLB"

						if @matchup.fav_ml.to_i > -130

							consensus_info[:spread] = "low"

						elsif @matchup.fav_ml.to_i <= -130 && @matchup.fav_ml.to_i > -160

							consensus_info[:spread] = "med"
						
						elsif @matchup.fav_ml.to_i <= -160 

							consensus_info[:spread] = "hi"

						end


					else

						if @matchup.spread.to_i > -4

							consensus_info[:spread] = "low"

						elsif @matchup.spread.to_i <= -4 && @matchup.spread.to_i > -8

							consensus_info[:spread] = "med"
						
						elsif @matchup.spread.to_i <= -8

							consensus_info[:spread] = "hi"

						end


					end

					@favs_obj.push(consensus_info)

				elsif team == @matchup.dog

					consensus_info[:pick] = @matchup.dog

					if @matchup.fav_field.downcase == "home"

						consensus_info[:location] = "away"


					else

						consensus_info[:location] = "home"


					end

					if @matchup.sport.upcase == "MLB"

						if @matchup.dog_ml.to_i < 130

							consensus_info[:spread] = "low"

						elsif @matchup.dog_ml.to_i >= 130 && @matchup.dog_ml.to_i < 160

							consensus_info[:spread] = "med"
						
						elsif @matchup.dog_ml.to_i >= 160

							consensus_info[:spread] = "hi"

						end


					else

						if (@matchup.spread.to_f * -1) < 4

							consensus_info[:spread] = "low"

						elsif (@matchup.spread.to_f * -1) >= 4 && (@matchup.spread.to_i * -1) < 8

							consensus_info[:spread] = "med"
						
						elsif (@matchup.spread.to_f * -1) >= 8

							consensus_info[:spread] = "hi"

						end


					end

					@dogs_obj.push(consensus_info)
				
				elsif team == "O"

					if @matchup.sport == "MLB"

						if @matchup.total.to_i < 8

							consensus_info[:total] = "low"

						elsif @matchup.total.to_i >= 8 && @matchup.total.to_i < 10

							consensus_info[:total] = "med"

						else

							consensus_info[:total] = "hi"


						end

					elsif @matchup.sport == "NFL"

						if @matchup.total.to_i < 48

							consensus_info[:total] = "low"

						elsif @matchup.total.to_i >= 48 && @matchup.total.to_i < 53

							consensus_info[:total] = "med"

						else

							consensus_info[:total] = "hi"

						end
					
					elsif @matchup.sport == "NBA"

						if @matchup.total.to_i < 220

							consensus_info[:total] = "low"

						elsif @matchup.total.to_i >= 220 && @matchup.total.to_i < 228

							consensus_info[:total] = "med"
						
						else

							consensus_info[:total] = "hi"

						end


					end

					@ovr_obj.push(consensus_info)
				
				elsif team == "U"

					if @matchup.sport == "MLB"

						if @matchup.total.to_i < 8

							consensus_info[:total] = "low"

						elsif @matchup.total.to_i >= 8 && @matchup.total.to_i < 10

							consensus_info[:total] = "med"

						else

							consensus_info[:total] = "hi"


						end

					elsif @matchup.sport == "NFL"

						if @matchup.total.to_i < 48

							consensus_info[:total] = "low"

						elsif @matchup.total.to_i >= 48 && @matchup.total.to_i < 53

							consensus_info[:total] = "med"

						else

							consensus_info[:total] = "hi"

						end
					
					elsif @matchup.sport == "NBA"

						if @matchup.total.to_i < 220

							consensus_info[:total] = "low"

						elsif @matchup.total.to_i >= 220 && @matchup.total.to_i < 228

							consensus_info[:total] = "med"
						
						else

							consensus_info[:total] = "hi"

						end


					end

					@und_obj.push(consensus_info)

				end

			end

			@on_side = @favs_obj.length + @dogs_obj.length
			@on_total = @und_obj.length + @ovr_obj.length

		end


	end

	def calc_percent

		@fav_prcnt = (((@favs_obj.length / @on_side.to_f) * 100).round(2)).to_s + "%"
		@dog_prcnt = (((@dogs_obj.length / @on_side.to_f) * 100).round(2)).to_s + "%"
		@ovr_prcnt = (((@ovr_obj.length / @on_total.to_f) * 100).round(2)).to_s + "%"
		@und_prcnt = (((@und_obj.length / @on_total.to_f) * 100).round(2)).to_s + "%"


	end

	def overall_sport

		@consensus_info

		@favs_obj.each do |x|

			consensus_info = {}

			five_wins = 0
			five_losses = 0

			ten_wins = 0
			ten_losses = 0

			twenty_wins = 0
			twenty_losses = 0

			user_games = []

			User.all.each do |u|

				if u.id == x[:user_id].to_i

					u.picks.each do |p|

						if p.sport == @matchup.sport

							if p.bet_type == "side"

								Matchup.all.each do |m|

									if m.id == p.matchup_id.to_i

										if m.home_score.length != 0

											user_games.push(p)

										end


									end


								end

							end

						end



					end


				end


			end

			user_games_last_five = user_games.last(5)
			user_games_last_ten = user_games.last(10)
			user_games_last_twenty = user_games.last(20)

			consensus_info[:last_five_games] = user_games_last_five
			consensus_info[:last_ten_games] = user_games_last_ten
			consensus_info[:last_twenty_games] = user_games_last_twenty

			consensus_info[:last_five_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if team == m.fav

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										five_wins = five_wins + 1

									else

										five_losses = five_losses + 1

									end
						

								else

									if m.home_score.to_f + m.spread.to_f > m.road_score.to_i

										five_wins = five_wins + 1


									else

										five_losses = five_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										five_wins = five_wins + 1

									else

										five_losses = five_losses + 1

									end
						

								else

									if m.road_score.to_f + m.spread.to_f > m.home_score.to_i

										five_wins = five_wins + 1


									else

										five_losses = five_losses + 1


									end

								end


							end

						else

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										five_wins = five_wins + 1

									else

										five_losses = five_losses + 1

									end
						

								else

									if m.road_score.to_f + (m.spread.to_f * -1) > m.home_score.to_i

										five_wins = five_wins + 1


									else

										five_losses = five_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										five_wins = five_wins + 1

									else

										five_losses = five_losses + 1

									end
						

								else

									if m.home_score.to_f + (m.spread.to_f * -1) > m.road_score.to_i

										five_wins = five_wins + 1


									else

										five_losses = five_losses + 1


									end

								end


							end

						end


					end


				end

			end

			consensus_info[:last_ten_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if team == m.fav

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										ten_wins = ten_wins + 1

									else

										ten_losses = ten_losses + 1

									end
						

								else

									if m.home_score.to_f + m.spread.to_f > m.road_score.to_i

										ten_wins = ten_wins + 1


									else

										ten_losses = ten_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										ten_wins = ten_wins + 1

									else

										ten_losses = ten_losses + 1

									end
						

								else

									if m.road_score.to_f + (m.spread.to_f * -1)  > m.home_score.to_i

										ten_wins = ten_wins + 1


									else

										ten_losses = ten_losses + 1


									end

								end


							end

						else

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										ten_wins = ten_wins + 1

									else

										ten_losses = ten_losses + 1

									end
						

								else

									if m.road_score.to_f + (m.spread.to_f * -1) > m.home_score.to_i

										ten_wins = ten_wins + 1


									else

										ten_losses = ten_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										ten_wins = ten_wins + 1

									else

										ten_losses = ten_losses + 1

									end
						

								else

									if m.home_score.to_f + (m.spread.to_f * -1) > m.road_score.to_i

										ten_wins = ten_wins + 1


									else

										ten_losses = ten_losses + 1


									end

								end


							end

						end


					end


				end

			end

			consensus_info[:last_twenty_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if team == m.fav

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										twenty_wins = twenty_wins + 1

									else

										twenty_losses = twenty_losses + 1

									end
						

								else

									if m.home_score.to_f + m.spread.to_f > m.road_score.to_i

										twenty_wins = twenty_wins + 1


									else

										twenty_losses = twenty_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										twenty_wins = twenty_wins + 1

									else

										twenty_losses = twenty_losses + 1

									end
						

								else

									if m.road_score.to_f + (m.spread.to_f * -1)  > m.home_score.to_i

										twenty_wins = twenty_wins + 1


									else

										twenty_losses = twenty_losses + 1


									end

								end


							end

						else

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										twenty_wins = twenty_wins + 1

									else

										twenty_losses = twenty_losses + 1

									end
						

								else

									if m.road_score.to_f + (m.spread.to_f * -1) > m.home_score.to_i

										twenty_wins = twenty_wins + 1


									else

										twenty_losses = twenty_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										twenty_wins = twenty_wins + 1

									else

										twenty_losses = twenty_losses + 1

									end
						

								else

									if m.home_score.to_f + (m.spread.to_f * -1) > m.road_score.to_i

										twenty_wins = twenty_wins + 1


									else

										twenty_losses = twenty_losses + 1


									end

								end


							end

						end


					end


				end

			end

			if five_wins + five_losses == 0

				consensus_info[:over_all_last_five_prcnt] = "none"
				consensus_info[:last_five_rating] = "none"


			else 


				consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_five_prcnt].to_f <= 33.0

					consensus_info[:last_five_rating] = "frigid"


				elsif consensus_info[:over_all_last_five_prcnt].to_f > 33 && consensus_info[:over_all_last_five_prcnt].to_f < 40

					consensus_info[:last_five_rating] = "cold"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  40 && consensus_info[:over_all_last_five_prcnt].to_f < 60

					consensus_info[:last_five_rating] = "choppy"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  60 && consensus_info[:over_all_last_five_prcnt].to_f < 75

						consensus_info[:last_five_rating] = "hot"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >= 75
						
						consensus_info[:last_five_rating] = "on fire"


				end

			end

			if ten_wins + ten_losses == 0

				consensus_info[:over_all_last_ten_prcnt] = "none"
				consensus_info[:last_ten_rating] = "none"

			else

				consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins.to_f + ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_ten_prcnt].to_f <= 33.0

					consensus_info[:last_ten_rating] = "frigid"


				elsif consensus_info[:over_all_last_ten_prcnt].to_f > 33 && consensus_info[:over_all_last_ten_prcnt].to_f < 40

					consensus_info[:last_ten_rating] = "cold"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  40 && consensus_info[:over_all_last_ten_prcnt].to_f < 60

					consensus_info[:last_ten_rating] = "choppy"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  60 && consensus_info[:over_all_last_ten_prcnt].to_f < 75

						consensus_info[:last_ten_rating] = "hot"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 75
						
						consensus_info[:last_ten_rating] = "on fire"


				end

			end

			if twenty_wins + twenty_losses == 0

				consensus_info[:over_all_last_twenty_prcnt] = "none"
				consensus_info[:last_twenty_rating] = "none"

			else


				consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins.to_f + twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:last_twenty_rating] = "frigid"


				elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 33 && consensus_info[:over_all_last_twenty_prcnt].to_f < 40

					consensus_info[:last_twenty_rating] = "cold"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  40 && consensus_info[:over_all_last_twenty_prcnt].to_f < 60

					consensus_info[:last_twenty_rating] = "choppy"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  60 && consensus_info[:over_all_last_twenty_prcnt].to_f < 75

						consensus_info[:last_twenty_rating] = "hot"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:last_twenty_rating] = "on fire"


				end

			end

			@fav_bettors_info.push(consensus_info)


		end

		@dogs_obj.each do |x|

			consensus_info = {}

			five_wins = 0
			five_losses = 0

			ten_wins = 0
			ten_losses = 0

			twenty_wins = 0
			twenty_losses = 0

			user_games = []

			User.all.each do |u|

				if u.id == x[:user_id].to_i

					u.picks.each do |p|

						if p.sport == @matchup.sport

							if p.bet_type == "side"

								Matchup.all.each do |m|

									if m.id == p.matchup_id.to_i

										if m.home_score.length != 0

											user_games.push(p)

										end


									end


								end

							end

						end



					end


				end


			end

			user_games_last_five = user_games.last(5)
			user_games_last_ten = user_games.last(10)
			user_games_last_twenty = user_games.last(20)

			consensus_info[:last_five_games] = user_games_last_five
			consensus_info[:last_ten_games] = user_games_last_ten
			consensus_info[:last_twenty_games] = user_games_last_twenty

			consensus_info[:last_five_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if team == m.fav

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										five_wins = five_wins + 1

									else

										five_losses = five_losses + 1

									end
						

								else

									if m.home_score.to_f + m.spread.to_f > m.road_score.to_i

										five_wins = five_wins + 1


									else

										five_losses = five_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										five_wins = five_wins + 1

									else

										five_losses = five_losses + 1

									end
						

								else

									if m.road_score.to_f + (m.spread.to_f * -1) > m.home_score.to_i

										five_wins = five_wins + 1


									else

										five_losses = five_losses + 1


									end

								end


							end

						else

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										five_wins = five_wins + 1

									else

										five_losses = five_losses + 1

									end
						

								else

									if m.road_score.to_f + (m.spread.to_f * -1) > m.home_score.to_i

										five_wins = five_wins + 1


									else

										five_losses = five_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										five_wins = five_wins + 1

									else

										five_losses = five_losses + 1

									end
						

								else

									if m.home_score.to_f + (m.spread.to_f * -1) > m.road_score.to_i

										five_wins = five_wins + 1


									else

										five_losses = five_losses + 1


									end

								end


							end

						end


					end


				end

			end

			consensus_info[:last_ten_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if team == m.fav

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										ten_wins = ten_wins + 1

									else

										ten_losses = ten_losses + 1

									end
						

								else

									if m.home_score.to_f + m.spread.to_f > m.road_score.to_i

										ten_wins = ten_wins + 1


									else

										ten_losses = ten_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										ten_wins = ten_wins + 1

									else

										ten_losses = ten_losses + 1

									end
						

								else

									if m.road_score.to_f + m.spread.to_f  > m.home_score.to_i

										ten_wins = ten_wins + 1


									else

										ten_losses = ten_losses + 1


									end

								end


							end

						else

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										ten_wins = ten_wins + 1

									else

										ten_losses = ten_losses + 1

									end
						

								else

									if m.road_score.to_f + (m.spread.to_f * -1) > m.home_score.to_i

										ten_wins = ten_wins + 1


									else

										ten_losses = ten_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										ten_wins = ten_wins + 1

									else

										ten_losses = ten_losses + 1

									end
						

								else

									if m.home_score.to_f + (m.spread.to_f * -1) > m.road_score.to_i

										ten_wins = ten_wins + 1


									else

										ten_losses = ten_losses + 1


									end

								end


							end

						end


					end


				end

			end

			consensus_info[:last_twenty_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if team == m.fav

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										twenty_wins = twenty_wins + 1

									else

										twenty_losses = twenty_losses + 1

									end
						

								else

									if m.home_score.to_f + m.spread.to_f > m.road_score.to_i

										twenty_wins = twenty_wins + 1


									else

										twenty_losses = twenty_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										twenty_wins = twenty_wins + 1

									else

										twenty_losses = twenty_losses + 1

									end
						

								else

									if m.road_score.to_f + m.spread.to_f  > m.home_score.to_i

										twenty_wins = twenty_wins + 1


									else

										twenty_losses = twenty_losses + 1


									end

								end


							end

						else

							if m.fav_field == "home"

								if @matchup.sport == "MLB" 

									if m.road_score.to_i > m.home_score.to_i

										twenty_wins = twenty_wins + 1

									else

										twenty_losses = twenty_losses + 1

									end
						

								else

									if m.road_score.to_f + (m.spread.to_f * -1) > m.home_score.to_i

										twenty_wins = twenty_wins + 1


									else

										twenty_losses = twenty_losses + 1


									end

								end

							else 

								if @matchup.sport == "MLB" 

									if m.home_score.to_i > m.road_score.to_i

										twenty_wins = twenty_wins + 1

									else

										twenty_losses = twenty_losses + 1

									end
						

								else

									if m.home_score.to_f + (m.spread.to_f * -1) > m.road_score.to_i

										twenty_wins = ten_wins + 1


									else

										twenty_losses = ten_losses + 1


									end

								end


							end

						end


					end


				end

			end

			if five_losses + five_wins == 0

				consensus_info[:over_all_last_five_prcnt] = "none"
				consensus_info[:last_five_rating] = "none"

			else


				consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_five_prcnt].to_f <= 33.0

					consensus_info[:last_five_rating] = "frigid"


				elsif consensus_info[:over_all_last_five_prcnt].to_f > 33 && consensus_info[:over_all_last_five_prcnt].to_f < 40

					consensus_info[:last_five_rating] = "cold"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  40 && consensus_info[:over_all_last_five_prcnt].to_f < 60

					consensus_info[:last_five_rating] = "choppy"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  60 && consensus_info[:over_all_last_five_prcnt].to_f < 75

						consensus_info[:last_five_rating] = "hot"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >= 75
						
						consensus_info[:last_five_rating] = "on fire"


				end

			end

			if ten_wins + ten_losses == 0

				consensus_info[:over_all_last_ten_prcnt] = "none"
				consensus_info[:last_ten_rating] = "none"

			else


				consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins + ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_ten_prcnt].to_f <= 33.0

					consensus_info[:last_ten_rating] = "frigid"


				elsif consensus_info[:over_all_last_ten_prcnt].to_f > 33 && consensus_info[:over_all_last_ten_prcnt].to_f < 40

					consensus_info[:last_ten_rating] = "cold"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  40 && consensus_info[:over_all_last_ten_prcnt].to_f < 60

					consensus_info[:last_ten_rating] = "choppy"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  60 && consensus_info[:over_all_last_ten_prcnt].to_f < 75

						consensus_info[:last_ten_rating] = "hot"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 75
						
						consensus_info[:last_ten_rating] = "on fire"


				end

			end

			if twenty_losses + twenty_wins == 0

				consensus_info[:over_all_last_twenty_prcnt] = "none"
				consensus_info[:last_twenty_rating] = "none"

			else

				consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins + twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:last_twenty_rating] = "frigid"


				elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 33.0 && consensus_info[:over_all_last_twenty_prcnt].to_f < 40

					consensus_info[:last_twenty_rating] = "cold"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  40 && consensus_info[:over_all_last_twenty_prcnt].to_f < 60

					consensus_info[:last_twenty_rating] = "choppy"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  60 && consensus_info[:over_all_last_twenty_prcnt].to_f < 75

						consensus_info[:last_twenty_rating] = "hot"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:last_twenty_rating] = "on fire"


				end

			end

			@dog_bettors_info.push(consensus_info)
			
		end

		@ovr_obj.each do |x|

			consensus_info = {}

			five_wins = 0
			five_losses = 0

			ten_wins = 0
			ten_losses = 0

			twenty_wins = 0
			twenty_losses = 0

			user_games = []

			User.all.each do |u|

				if u.id == x[:user_id].to_i

					u.picks.each do |p|

						if p.sport == @matchup.sport

							if p.bet_type == "total"

								Matchup.all.each do |m|

									if m.id == p.matchup_id.to_i

										if m.home_score.length != 0

											user_games.push(p)

										end


									end


								end

							end

						end



					end


				end


			end

			user_games_last_five = user_games.last(5)
			user_games_last_ten = user_games.last(10)
			user_games_last_twenty = user_games.last(20)

			consensus_info[:last_five_games] = user_games_last_five
			consensus_info[:last_ten_games] = user_games_last_ten
			consensus_info[:last_twenty_games] = user_games_last_twenty

			consensus_info[:last_five_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if team == "O"

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

								five_wins = five_wins + 1
							
							else 

								
								five_losses = five_losses + 1


							end

						else

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								five_wins = five_wins + 1

							else

								five_losses = five_losses + 1

							end

						end


					end


				end

			end

			consensus_info[:last_ten_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if team == "O"

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

								ten_wins = ten_wins + 1
							
							else 

								
								ten_losses = ten_losses + 1


							end

						else

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								ten_wins = ten_wins + 1

							else

								ten_losses = ten_losses + 1

							end

						end


					end


				end

			end

			consensus_info[:last_twenty_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")


				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						@team_check.push(team)

						if team == "O"

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

								twenty_wins = twenty_wins + 1
							
							else 

								
								twenty_losses = twenty_losses + 1


							end

						else

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								twenty_wins = twenty_wins + 1

							else

								twenty_losses = twenty_losses + 1

							end

						end


					end


				end

			end

			if five_wins + five_losses == 0

				consensus_info[:over_all_last_five_prcnt] = "none"
				consensus_info[:last_five_rating] = "none"

			else

				consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_five_prcnt].to_f <= 33.0

					consensus_info[:last_five_rating] = "frigid"


				elsif consensus_info[:over_all_last_five_prcnt].to_f > 33 && consensus_info[:over_all_last_five_prcnt].to_f < 40

					consensus_info[:last_five_rating] = "cold"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  40 && consensus_info[:over_all_last_five_prcnt].to_f < 60

					consensus_info[:last_five_rating] = "choppy"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  60 && consensus_info[:over_all_last_five_prcnt].to_f < 75

						consensus_info[:last_five_rating] = "hot"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >= 75
						
						consensus_info[:last_five_rating] = "on fire"


				end

			end

			if ten_wins + ten_losses == 0

				consensus_info[:over_all_last_ten_prcnt] = "none"
				consensus_info[:last_ten_rating] = "none"

			else

				consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins + ten_losses)) * 100).round(2)).to_s + "%"


				if consensus_info[:over_all_last_ten_prcnt].to_f <= 33.0

					consensus_info[:last_ten_rating] = "frigid"


				elsif consensus_info[:over_all_last_ten_prcnt].to_f > 33 && consensus_info[:over_all_last_ten_prcnt].to_f < 40

					consensus_info[:last_ten_rating] = "cold"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  40 && consensus_info[:over_all_last_ten_prcnt].to_f < 60

					consensus_info[:last_ten_rating] = "choppy"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  60 && consensus_info[:over_all_last_ten_prcnt].to_f < 75

						consensus_info[:last_ten_rating] = "hot"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 75
						
						consensus_info[:last_ten_rating] = "on fire"


				end

			end

			if twenty_wins + twenty_losses == 0

				consensus_info[:over_all_last_twenty_prcnt] = "none"
				consensus_info[:last_twenty_rating] = "none"

			else


				consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins + twenty_losses)) * 100).round(2)).to_s + "%"


				if consensus_info[:over_all_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:last_twenty_rating] = "frigid"


				elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 33 && consensus_info[:over_all_last_twenty_prcnt].to_f < 40

					consensus_info[:last_twenty_rating] = "cold"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  40 && consensus_info[:over_all_last_twenty_prcnt].to_f < 60

					consensus_info[:last_twenty_rating] = "choppy"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 60 && consensus_info[:over_all_last_twenty_prcnt].to_f < 75

						consensus_info[:last_twenty_rating] = "hot"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:last_twenty_rating] = "on fire"


				end

			end

			@ovr_bettors_info.push(consensus_info)

		end

		@und_obj.each do |x|

			consensus_info = {}

			five_wins = 0
			five_losses = 0

			ten_wins = 0
			ten_losses = 0

			twenty_wins = 0
			twenty_losses = 0

			user_games = []

			User.all.each do |u|

				if u.id == x[:user_id].to_i

					u.picks.each do |p|

						if p.sport == @matchup.sport

							if p.bet_type == "total"

								Matchup.all.each do |m|

									if m.id == p.matchup_id.to_i

										if m.home_score.length != 0

											user_games.push(p)

										end


									end


								end

							end

						end



					end


				end


			end

			user_games_last_five = user_games.last(5)
			user_games_last_ten = user_games.last(10)
			user_games_last_twenty = user_games.last(20)

			consensus_info[:last_five_games] = user_games_last_five
			consensus_info[:last_ten_games] = user_games_last_ten
			consensus_info[:last_twenty_games] = user_games_last_twenty

			consensus_info[:last_five_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if team == "O"

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

								five_wins = five_wins + 1
							
							else 

								
								five_losses = five_losses + 1


							end

						else

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								five_wins = five_wins + 1

							else

								five_losses = five_losses + 1

							end

						end


					end


				end

			end

			consensus_info[:last_ten_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if team == "O"

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

								ten_wins = ten_wins + 1
							
							else 

								
								ten_losses = ten_losses + 1


							end

						else

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								ten_wins = ten_wins + 1

							else

								ten_losses = ten_losses + 1

							end

						end


					end


				end

			end

			consensus_info[:last_twenty_games].each do |g|

				team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")


				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						@team_check.push(team)

						if team == "O"

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

								twenty_wins = twenty_wins + 1
							
							else 

								
								twenty_losses = twenty_losses + 1


							end

						else

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								twenty_wins = twenty_wins + 1

							else

								twenty_losses = twenty_losses + 1

							end

						end


					end


				end

			end

			if five_wins + five_losses == 0

				consensus_info[:over_all_last_five_prcnt] = "none"
				consensus_info[:last_five_rating] = "none"

			else

				consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_five_prcnt].to_f <= 33.0

					consensus_info[:last_five_rating] = "frigid"


				elsif consensus_info[:over_all_last_five_prcnt].to_f > 33 && consensus_info[:over_all_last_five_prcnt].to_f < 40

					consensus_info[:last_five_rating] = "cold"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  40 && consensus_info[:over_all_last_five_prcnt].to_f < 60

					consensus_info[:last_five_rating] = "choppy"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  60 && consensus_info[:over_all_last_five_prcnt].to_f < 75

						consensus_info[:last_five_rating] = "hot"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >= 75
						
						consensus_info[:last_five_rating] = "on fire"


				end

			end

			if ten_wins + ten_losses == 0

				consensus_info[:over_all_last_ten_prcnt] = "none"
				consensus_info[:last_ten_rating] = "none"

			else

				consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins + ten_losses)) * 100).round(2)).to_s + "%"


				if consensus_info[:over_all_last_ten_prcnt].to_f <= 33.0

					consensus_info[:last_ten_rating] = "frigid"


				elsif consensus_info[:over_all_last_ten_prcnt].to_f > 33 && consensus_info[:over_all_last_ten_prcnt].to_f < 40

					consensus_info[:last_ten_rating] = "cold"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  40 && consensus_info[:over_all_last_ten_prcnt].to_f < 60

					consensus_info[:last_ten_rating] = "choppy"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  60 && consensus_info[:over_all_last_ten_prcnt].to_f < 75

						consensus_info[:last_ten_rating] = "hot"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 75
						
						consensus_info[:last_ten_rating] = "on fire"


				end

			end

			if twenty_wins + twenty_losses == 0

				consensus_info[:over_all_last_twenty_prcnt] = "none"
				consensus_info[:last_twenty_rating] = "none"

			else


				consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins + twenty_losses)) * 100).round(2)).to_s + "%"


				if consensus_info[:over_all_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:last_twenty_rating] = "frigid"


				elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 33 && consensus_info[:over_all_last_twenty_prcnt].to_f < 40

					consensus_info[:last_twenty_rating] = "cold"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  40 && consensus_info[:over_all_last_twenty_prcnt].to_f < 60

					consensus_info[:last_twenty_rating] = "choppy"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 60 && consensus_info[:over_all_last_twenty_prcnt].to_f < 75

						consensus_info[:last_twenty_rating] = "hot"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:last_twenty_rating] = "on fire"


				end

			end

			@und_bettors_info.push(consensus_info)

		end

		
	end

	def line_for_sport

		@favs_obj.each do |f|

			consensus_info = {}

			low_spread_five_wins = 0
			low_spread_five_losses = 0

			low_spread_ten_wins = 0
			low_spread_ten_losses = 0

			low_spread_twenty_wins = 0
			low_spread_twenty_losses = 0

			med_spread_five_wins = 0
			med_spread_five_losses = 0

			med_spread_ten_wins = 0
			med_spread_ten_losses = 0

			med_spread_twenty_wins = 0
			med_spread_twenty_losses = 0

			hi_spread_five_wins = 0
			hi_spread_five_losses = 0

			hi_spread_ten_wins = 0
			hi_spread_ten_losses = 0

			hi_spread_twenty_wins = 0
			hi_spread_twenty_losses = 0


			low_spread_picks = []
			med_spread_picks = []
			hi_spread_picks = []

			User.all.each do |u|

				if f[:user_id].to_i == u.id

					u.picks.each do |p|

						team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

						if p.sport == @matchup.sport

							if p.bet_type == "side"

								Matchup.all.each do |m|

									if p.matchup_id.to_i == m.id

										if m.home_score.length > 0

											if @matchup.sport.upcase == "MLB"

												if team == m.fav

													if (m.fav_ml.to_i).abs < 130

														low_spread_picks.push(p)


													elsif (m.fav_ml.to_i).abs >= 130 && (m.fav_ml.to_i).abs < 160

														med_spread_picks.push(p)

													
													else

														hi_spread_picks.push(p)


													end


												elsif team == m.dog

													if (m.dog_ml.to_i).abs < 130

														low_spread_picks.push(p)


													elsif (m.dog_ml.to_i).abs >= 130 && (m.dog_ml.to_i).abs < 160

														med_spread_picks.push(p)

													
													else

														hi_spread_picks.push(p)


													end



												end


											else

												if @matchup.spread.to_i > -4

													low_spread_picks.push(p)

												elsif @matchup.spread.to_i <= -4 && @matchup.spread.to_i > -8

													med_spread_picks.push(p)

												elsif @matchup.spread.to_i <= -8

													hi_spread_picks.push(p)

												end
													
											end

										end


									end



								end

							end


						end


					end

				end

			end		

			if f[:spread] == "low"

				low_spread_picks.last(5).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1

										else

											low_spread_five_losses = low_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										else 

											low_spread_five_losses = low_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_five_losses = low_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											low_spread_five_losses = low_spread_five_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											low_spread_five_losses = low_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										else 

											low_spread_five_losses = low_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_five_losses = low_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											low_spread_five_losses = low_spread_five_losses + 1

										end


									end

								end


							end

						end


					end


				end

				low_spread_picks.last(10).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1

										else

											low_spread_ten_losses = low_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										else 

											low_spread_ten_losses = low_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_ten_losses = low_spread_ten_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											low_spread_ten_losses = low_spread_ten_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											low_spread_ten_losses = low_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										else 

											low_spread_ten_losses = low_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_ten_losses = low_spread_ten_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											low_spread_ten_losses = low_spread_ten_losses + 1

										end


									end

								end


							end

						end


					end

				end

				low_spread_picks.last(20).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1

										else

											low_spread_twenty_losses = low_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										else 

											low_spread_twenty_losses = low_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_twenty_losses = low_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											low_spread_twenty_losses = low_spread_twenty_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											low_spread_twenty_losses = low_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										else 

											low_spread_twenty_losses = low_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_twenty_losses = low_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											low_spread_twenty_losses = low_spread_twenty_losses + 1

										end


									end

								end


							end

						end


					end


				end

				if (low_spread_five_wins + low_spread_five_losses) != 0

					consensus_info[:low_spread_five_prcnt] = ((low_spread_five_wins.to_f/(low_spread_five_wins + low_spread_five_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:low_spread_five_prcnt].to_f <= 33.0

						consensus_info[:low_spread_five_rating] = "frigid"

					elsif consensus_info[:low_spread_five_prcnt].to_f > 33 && consensus_info[:low_spread_five_prcnt].to_f < 40

						consensus_info[:low_spread_five_rating] = "cold"

					elsif consensus_info[:low_spread_five_prcnt].to_f >= 40 && consensus_info[:low_spread_five_prcnt].to_f < 60

						consensus_info[:low_spread_five_rating] = "choppy"

					elsif consensus_info[:low_spread_five_prcnt].to_f >= 60 && consensus_info[:low_spread_five_prcnt].to_f < 75

						consensus_info[:low_spread_five_rating] = "hot"

					elsif consensus_info[:low_spread_five_prcnt].to_f >= 75

						consensus_info[:low_spread_five_rating] = "on fire"

					end
				else

					consensus_info[:low_spread_five_rating] = "none"
					consensus_info[:low_spread_five_prcnt] = "none"


				end

				if (low_spread_ten_wins + low_spread_ten_losses) != 0

					consensus_info[:low_spread_ten_prcnt] = ((low_spread_ten_wins.to_f/(low_spread_ten_wins + low_spread_ten_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:low_spread_ten_prcnt].to_f <= 33.0

						consensus_info[:low_spread_ten_rating] = "frigid"

					elsif consensus_info[:low_spread_ten_prcnt].to_f > 33 && consensus_info[:low_spread_ten_prcnt].to_f < 40

						consensus_info[:low_spread_ten_rating] = "cold"

					elsif consensus_info[:low_spread_ten_prcnt].to_f >= 40 && consensus_info[:low_spread_ten_prcnt].to_f < 60

						consensus_info[:low_spread_ten_rating] = "choppy"

					elsif consensus_info[:low_spread_ten_prcnt].to_f >= 60 && consensus_info[:low_spread_ten_prcnt].to_f < 75

						consensus_info[:low_spread_ten_rating] = "hot"

					elsif consensus_info[:low_spread_ten_prcnt].to_f >= 75

						consensus_info[:low_spread_ten_rating] = "on fire"

					end
				
				else

					consensus_info[:low_spread_ten_rating] = "none"
					consensus_info[:low_spread_ten_prcnt] = "none"


				end


				if (low_spread_twenty_wins + low_spread_twenty_losses) != 0

					consensus_info[:low_spread_twenty_prcnt] = ((low_spread_twenty_wins.to_f/(low_spread_twenty_wins + low_spread_twenty_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:low_spread_twenty_prcnt].to_f <= 33.0

						consensus_info[:low_spread_twenty_rating] = "frigid"

					elsif consensus_info[:low_spread_twenty_prcnt].to_f > 33 && consensus_info[:low_spread_twenty_prcnt].to_f < 40

						consensus_info[:low_spread_twenty_rating] = "cold"

					elsif consensus_info[:low_spread_twenty_prcnt].to_f >= 40 && consensus_info[:low_spread_twenty_prcnt].to_f < 60

						consensus_info[:low_spread_twenty_rating] = "choppy"

					elsif consensus_info[:low_spread_twenty_prcnt].to_f >= 60 && consensus_info[:low_spread_twenty_prcnt].to_f < 75

						consensus_info[:low_spread_twenty_rating] = "hot"

					elsif consensus_info[:low_spread_twenty_prcnt].to_f >= 75

						consensus_info[:low_spread_twenty_rating] = "on fire"

					end
				
				else

					consensus_info[:low_spread_twenty_rating] = "none"
					consensus_info[:low_spread_twenty_prcnt] = "none"


				end
				
			elsif f[:spread] == "med"

				med_spread_picks.last(5).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1

										else

											med_spread_five_losses = med_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										else 

											med_spread_five_losses = med_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_five_losses = med_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											med_spread_five_losses = med_spread_five_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											med_spread_five_losses = med_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										else 

											med_spread_five_losses = med_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_five_losses = med_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											med_spread_five_losses = med_spread_five_losses + 1

										end


									end

								end


							end

						end


					end


				end

				med_spread_picks.last(10).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1

										else

											med_spread_ten_losses = med_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										else 

											med_spread_ten_losses = med_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_ten_losses = med_spread_ten_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											med_spread_ten_losses = med_spread_ten_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											med_spread_ten_losses = med_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										else 

											med_spread_ten_losses = med_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_ten_losses = med_spread_ten_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											med_spread_ten_losses = med_spread_ten_losses + 1

										end


									end

								end


							end

						end


					end

				end

				med_spread_picks.last(20).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1

										else

											med_spread_twenty_losses = med_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										else 

											med_spread_twenty_losses = med_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_twenty_losses = med_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											med_spread_twenty_losses = med_spread_twenty_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											med_spread_twenty_losses = med_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										else 

											med_spread_twenty_losses = med_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_twenty_losses = med_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											med_spread_twenty_losses = med_spread_twenty_losses + 1

										end


									end

								end


							end

						end


					end


				end

				if (med_spread_five_wins + med_spread_five_losses) != 0

					consensus_info[:med_spread_five_prcnt] = ((med_spread_five_wins.to_f/(med_spread_five_wins + med_spread_five_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:med_spread_five_prcnt].to_f <= 33.0

						consensus_info[:med_spread_five_rating] = "frigid"

					elsif consensus_info[:med_spread_five_prcnt].to_f > 33 && consensus_info[:med_spread_five_prcnt].to_f < 40

						consensus_info[:med_spread_five_rating] = "cold"

					elsif consensus_info[:med_spread_five_prcnt].to_f >= 40 && consensus_info[:med_spread_five_prcnt].to_f < 60

						consensus_info[:med_spread_five_rating] = "choppy"

					elsif consensus_info[:med_spread_five_prcnt].to_f >= 60 && consensus_info[:med_spread_five_prcnt].to_f < 75

						consensus_info[:med_spread_five_rating] = "hot"

					elsif consensus_info[:med_spread_five_prcnt].to_f >= 75

						consensus_info[:med_spread_five_rating] = "on fire"

					end
				else

					consensus_info[:med_spread_five_rating] = "none"
					consensus_info[:med_spread_five_prcnt] = "none"


				end

				if (med_spread_ten_wins + med_spread_ten_losses) != 0

					consensus_info[:med_spread_ten_prcnt] = ((med_spread_ten_wins.to_f/(med_spread_ten_wins + med_spread_ten_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:med_spread_ten_prcnt].to_f <= 33.0

						consensus_info[:med_spread_ten_rating] = "frigid"

					elsif consensus_info[:med_spread_ten_prcnt].to_f > 33 && consensus_info[:med_spread_ten_prcnt].to_f < 40

						consensus_info[:med_spread_ten_rating] = "cold"

					elsif consensus_info[:med_spread_ten_prcnt].to_f >= 40 && consensus_info[:med_spread_ten_prcnt].to_f < 60

						consensus_info[:med_spread_ten_rating] = "choppy"

					elsif consensus_info[:med_spread_ten_prcnt].to_f >= 60 && consensus_info[:med_spread_ten_prcnt].to_f < 75

						consensus_info[:med_spread_ten_rating] = "hot"

					elsif consensus_info[:med_spread_ten_prcnt].to_f >= 75

						consensus_info[:med_spread_ten_rating] = "on fire"

					end
				
				else

					consensus_info[:med_spread_ten_rating] = "none"
					consensus_info[:med_spread_ten_prcnt] = "none"


				end


				if (med_spread_twenty_wins + med_spread_twenty_losses) != 0



					consensus_info[:med_spread_twenty_prcnt] = ((med_spread_twenty_wins.to_f/(med_spread_twenty_wins + med_spread_twenty_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:med_spread_twenty_prcnt].to_f <= 33.0

						consensus_info[:med_spread_twenty_rating] = "frigid"

					elsif consensus_info[:med_spread_twenty_prcnt].to_f > 33 && consensus_info[:med_spread_twenty_prcnt].to_f < 40

						consensus_info[:med_spread_twenty_rating] = "cold"

					elsif consensus_info[:med_spread_twenty_prcnt].to_f >= 40 && consensus_info[:med_spread_twenty_prcnt].to_f < 60

						consensus_info[:med_spread_twenty_rating] = "choppy"

					elsif consensus_info[:med_spread_twenty_prcnt].to_f >= 60 && consensus_info[:med_spread_twenty_prcnt].to_f < 75

						consensus_info[:med_spread_twenty_rating] = "hot"

					elsif consensus_info[:med_spread_twenty_prcnt].to_f >= 75

						consensus_info[:med_spread_twenty_rating] = "on fire"

					end
				
				else

					consensus_info[:med_spread_twenty_rating] = "none"
					consensus_info[:med_spread_twenty_prcnt] = "none"


				end
				
			elsif f[:spread] == "hi"

				hi_spread_picks.last(5).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1

										else

											hi_spread_five_losses = hi_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										else 

											hi_spread_five_losses = hi_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_five_losses = hi_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											hi_spread_five_losses = hi_spread_five_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											hi_spread_five_losses = hi_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										else 

											hi_spread_five_losses = hi_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_five_losses = hi_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											hi_spread_five_losses = hi_spread_five_losses + 1

										end


									end

								end


							end

						end


					end


				end

				hi_spread_picks.last(10).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1

										else

											hi_spread_ten_losses = hi_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										else 

											hi_spread_ten_losses = hi_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_ten_losses = hi_spread_ten_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											hi_spread_ten_losses = hi_spread_ten_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											hi_spread_ten_losses = hi_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										else 

											hi_spread_ten_losses = hi_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_ten_losses = hi_spread_ten_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											hi_spread_ten_losses = hi_spread_ten_losses + 1

										end


									end

								end


							end

						end


					end

				end

				hi_spread_picks.last(20).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1

										else

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										else 

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										else 

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1

										end


									end

								end


							end

						end


					end


				end

				if (hi_spread_five_wins + hi_spread_five_losses) != 0

					consensus_info[:hi_spread_five_prcnt] = ((hi_spread_five_wins.to_f/(hi_spread_five_wins + hi_spread_five_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:hi_spread_five_prcnt].to_f <= 33.0

						consensus_info[:hi_spread_five_rating] = "frigid"

					elsif consensus_info[:hi_spread_five_prcnt].to_f > 33 && consensus_info[:hi_spread_five_prcnt].to_f < 40

						consensus_info[:hi_spread_five_rating] = "cold"

					elsif consensus_info[:hi_spread_five_prcnt].to_f >= 40 && consensus_info[:hi_spread_five_prcnt].to_f < 60

						consensus_info[:hi_spread_five_rating] = "choppy"

					elsif consensus_info[:hi_spread_five_prcnt].to_f >= 60 && consensus_info[:hi_spread_five_prcnt].to_f < 75

						consensus_info[:hi_spread_five_rating] = "hot"

					elsif consensus_info[:hi_spread_five_prcnt].to_f >= 75

						consensus_info[:hi_spread_five_rating] = "on fire"

					end
				else

					consensus_info[:hi_spread_five_rating] = "none"
					consensus_info[:hi_spread_five_prcnt] = "none"


				end

				if (hi_spread_ten_wins + hi_spread_ten_losses) != 0

					consensus_info[:hi_spread_ten_prcnt] = ((hi_spread_ten_wins.to_f/(hi_spread_ten_wins + hi_spread_ten_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:hi_spread_ten_prcnt].to_f <= 33.0

						consensus_info[:hi_spread_ten_rating] = "frigid"

					elsif consensus_info[:hi_spread_ten_prcnt].to_f > 33 && consensus_info[:hi_spread_ten_prcnt].to_f < 40

						consensus_info[:hi_spread_ten_rating] = "cold"

					elsif consensus_info[:hi_spread_ten_prcnt].to_f >= 40 && consensus_info[:hi_spread_ten_prcnt].to_f < 60

						consensus_info[:hi_spread_ten_rating] = "choppy"

					elsif consensus_info[:hi_spread_ten_prcnt].to_f >= 60 && consensus_info[:hi_spread_ten_prcnt].to_f < 75

						consensus_info[:hi_spread_ten_rating] = "hot"

					elsif consensus_info[:hi_spread_ten_prcnt].to_f >= 75

						consensus_info[:hi_spread_ten_rating] = "on fire"

					end
				
				else

					consensus_info[:hi_spread_ten_rating] = "none"
					consensus_info[:hi_spread_ten_prcnt] = "none"


				end


				if (hi_spread_twenty_wins + hi_spread_twenty_losses) != 0

					consensus_info[:hi_spread_twenty_prcnt] = ((hi_spread_twenty_wins.to_f/(hi_spread_twenty_wins + hi_spread_twenty_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:hi_spread_twenty_prcnt].to_f <= 33.0

						consensus_info[:hi_spread_twenty_rating] = "frigid"

					elsif consensus_info[:hi_spread_twenty_prcnt].to_f > 33 && consensus_info[:hi_spread_twenty_prcnt].to_f < 40

						consensus_info[:hi_spread_twenty_rating] = "cold"

					elsif consensus_info[:hi_spread_twenty_prcnt].to_f >= 40 && consensus_info[:hi_spread_twenty_prcnt].to_f < 60

						consensus_info[:hi_spread_twenty_rating] = "choppy"

					elsif consensus_info[:hi_spread_twenty_prcnt].to_f >= 60 && consensus_info[:hi_spread_twenty_prcnt].to_f < 75

						consensus_info[:hi_spread_twenty_rating] = "hot"

					elsif consensus_info[:hi_spread_twenty_prcnt].to_f >= 75

						consensus_info[:hi_spread_twenty_rating] = "on fire"

					end
				
				else

					consensus_info[:hi_spread_twenty_rating] = "none"
					consensus_info[:hi_spread_twenty_prcnt] = "none"


				end

			end

			@fav_spread_info.push(consensus_info)

		end

		@dogs_obj.each do |f|

			consensus_info = {}

			low_spread_five_wins = 0
			low_spread_five_losses = 0

			low_spread_ten_wins = 0
			low_spread_ten_losses = 0

			low_spread_twenty_wins = 0
			low_spread_twenty_losses = 0

			med_spread_five_wins = 0
			med_spread_five_losses = 0

			med_spread_ten_wins = 0
			med_spread_ten_losses = 0

			med_spread_twenty_wins = 0
			med_spread_twenty_losses = 0

			hi_spread_five_wins = 0
			hi_spread_five_losses = 0

			hi_spread_ten_wins = 0
			hi_spread_ten_losses = 0

			hi_spread_twenty_wins = 0
			hi_spread_twenty_losses = 0


			low_spread_picks = []
			med_spread_picks = []
			hi_spread_picks = []

			User.all.each do |u|

				if f[:user_id].to_i == u.id

					u.picks.each do |p|

						team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

						if p.sport == @matchup.sport

							if p.bet_type == "side"

								Matchup.all.each do |m|

									if p.matchup_id.to_i == m.id

										if m.home_score.length > 0

											if @matchup.sport.upcase == "MLB"

												if team == m.fav

													if (m.fav_ml.to_i).abs < 130

														low_spread_picks.push(p)


													elsif (m.fav_ml.to_i).abs >= 130 && (m.fav_ml.to_i).abs < 160

														med_spread_picks.push(p)

													
													else

														hi_spread_picks.push(p)


													end


												elsif team == m.dog

													if (m.dog_ml.to_i).abs < 130

														low_spread_picks.push(p)


													elsif (m.dog_ml.to_i).abs >= 130 && (m.dog_ml.to_i).abs < 160

														med_spread_picks.push(p)

													
													else

														hi_spread_picks.push(p)


													end



												end


											else

												if @matchup.spread.to_i > -4

													low_spread_picks.push(p)

												elsif @matchup.spread.to_i <= -4 && @matchup.spread.to_i > -8

													med_spread_picks.push(p)

												elsif @matchup.spread.to_i <= -8

													hi_spread_picks.push(p)

												end
													
											end

										end


									end



								end

							end


						end


					end

				end

			end		

			if f[:spread] == "low"

				low_spread_picks.last(5).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1

										else

											low_spread_five_losses = low_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										else 

											low_spread_five_losses = low_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_five_losses = low_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											low_spread_five_losses = low_spread_five_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											low_spread_five_losses = low_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										else 

											low_spread_five_losses = low_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_five_losses = low_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											low_spread_five_wins = low_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											low_spread_five_losses = low_spread_five_losses + 1

										end


									end

								end


							end

						end


					end


				end

				low_spread_picks.last(10).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1

										else

											low_spread_ten_losses = low_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										else 

											low_spread_ten_losses = low_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_ten_losses = low_spread_ten_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											low_spread_ten_losses = low_spread_ten_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											low_spread_ten_losses = low_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										else 

											low_spread_ten_losses = low_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_ten_losses = low_spread_ten_wins + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											low_spread_ten_wins = low_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											low_spread_ten_losses = low_spread_ten_losses + 1

										end


									end

								end


							end

						end


					end

				end

				low_spread_picks.last(20).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1

										else

											low_spread_twenty_losses = low_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										else 

											low_spread_twenty_losses = low_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_twenty_losses = low_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											low_spread_twenty_losses = low_spread_twenty_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											low_spread_twenty_losses = low_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										else 

											low_spread_twenty_losses = low_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											low_spread_twenty_losses = low_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											low_spread_twenty_wins = low_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											low_spread_twenty_losses = low_spread_twenty_losses + 1

										end


									end

								end


							end

						end


					end


				end

				if (low_spread_five_wins + low_spread_five_losses) != 0

					consensus_info[:low_spread_five_prcnt] = ((low_spread_five_wins.to_f/(low_spread_five_wins + low_spread_five_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:low_spread_five_prcnt].to_f <= 33.0

						consensus_info[:low_spread_five_rating] = "frigid"

					elsif consensus_info[:low_spread_five_prcnt].to_f > 33 && consensus_info[:low_spread_five_prcnt].to_f < 40

						consensus_info[:low_spread_five_rating] = "cold"

					elsif consensus_info[:low_spread_five_prcnt].to_f >= 40 && consensus_info[:low_spread_five_prcnt].to_f < 60

						consensus_info[:low_spread_five_rating] = "choppy"

					elsif consensus_info[:low_spread_five_prcnt].to_f >= 60 && consensus_info[:low_spread_five_prcnt].to_f < 75

						consensus_info[:low_spread_five_rating] = "hot"

					elsif consensus_info[:low_spread_five_prcnt].to_f >= 75

						consensus_info[:low_spread_five_rating] = "on fire"

					end
				else

					consensus_info[:low_spread_five_rating] = "none"
					consensus_info[:low_spread_five_prcnt] = "none"


				end

				if (low_spread_ten_wins + low_spread_ten_losses) != 0

					consensus_info[:low_spread_ten_prcnt] = ((low_spread_ten_wins.to_f/(low_spread_ten_wins + low_spread_ten_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:low_spread_ten_prcnt].to_f <= 33.0

						consensus_info[:low_spread_ten_rating] = "frigid"

					elsif consensus_info[:low_spread_ten_prcnt].to_f > 33 && consensus_info[:low_spread_ten_prcnt].to_f < 40

						consensus_info[:low_spread_ten_rating] = "cold"

					elsif consensus_info[:low_spread_ten_prcnt].to_f >= 40 && consensus_info[:low_spread_ten_prcnt].to_f < 60

						consensus_info[:low_spread_ten_rating] = "choppy"

					elsif consensus_info[:low_spread_ten_prcnt].to_f >= 60 && consensus_info[:low_spread_ten_prcnt].to_f < 75

						consensus_info[:low_spread_ten_rating] = "hot"

					elsif consensus_info[:low_spread_ten_prcnt].to_f >= 75

						consensus_info[:low_spread_ten_rating] = "on fire"

					end
				
				else

					consensus_info[:low_spread_ten_rating] = "none"
					consensus_info[:low_spread_ten_prcnt] = "none"


				end


				if (low_spread_twenty_wins + low_spread_twenty_losses) != 0

					consensus_info[:low_spread_twenty_prcnt] = ((low_spread_twenty_wins.to_f/(low_spread_twenty_wins + low_spread_twenty_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:low_spread_twenty_prcnt].to_f <= 33.0

						consensus_info[:low_spread_twenty_rating] = "frigid"

					elsif consensus_info[:low_spread_twenty_prcnt].to_f > 33 && consensus_info[:low_spread_twenty_prcnt].to_f < 40

						consensus_info[:low_spread_twenty_rating] = "cold"

					elsif consensus_info[:low_spread_twenty_prcnt].to_f >= 40 && consensus_info[:low_spread_twenty_prcnt].to_f < 60

						consensus_info[:low_spread_twenty_rating] = "choppy"

					elsif consensus_info[:low_spread_twenty_prcnt].to_f >= 60 && consensus_info[:low_spread_twenty_prcnt].to_f < 75

						consensus_info[:low_spread_twenty_rating] = "hot"

					elsif consensus_info[:low_spread_twenty_prcnt].to_f >= 75

						consensus_info[:low_spread_twenty_rating] = "on fire"

					end
				
				else

					consensus_info[:low_spread_twenty_rating] = "none"
					consensus_info[:low_spread_twenty_prcnt] = "none"


				end
				
			elsif f[:spread] == "med"

				med_spread_picks.last(5).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1

										else

											med_spread_five_losses = med_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										else 

											med_spread_five_losses = med_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_five_losses = med_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											med_spread_five_losses = med_spread_five_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											med_spread_five_losses = med_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										else 

											med_spread_five_losses = med_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_five_losses = med_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											med_spread_five_wins = med_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											med_spread_five_losses = med_spread_five_losses + 1

										end


									end

								end


							end

						end


					end


				end

				med_spread_picks.last(10).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1

										else

											med_spread_ten_losses = med_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										else 

											med_spread_ten_losses = med_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_ten_losses = med_spread_ten_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											med_spread_ten_losses = med_spread_ten_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											med_spread_ten_losses = med_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										else 

											med_spread_ten_losses = med_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_ten_losses = med_spread_ten_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											med_spread_ten_wins = med_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											med_spread_ten_losses = med_spread_ten_losses + 1

										end


									end

								end


							end

						end


					end

				end

				med_spread_picks.last(20).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1

										else

											med_spread_twenty_losses = med_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										else 

											med_spread_twenty_losses = med_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_twenty_losses = med_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											med_spread_twenty_losses = med_spread_twenty_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											med_spread_twenty_losses = med_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										else 

											med_spread_twenty_losses = med_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											med_spread_twenty_losses = med_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											med_spread_twenty_wins = med_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											med_spread_twenty_losses = med_spread_twenty_losses + 1

										end


									end

								end


							end

						end


					end


				end

				if (med_spread_five_wins + med_spread_five_losses) != 0

					consensus_info[:med_spread_five_prcnt] = ((med_spread_five_wins.to_f/(med_spread_five_wins + med_spread_five_losses)).round(2) * 100).to_s + "%"	

					if consensus_info[:med_spread_five_prcnt].to_f <= 33.0

						consensus_info[:med_spread_five_rating] = "frigid"

					elsif consensus_info[:med_spread_five_prcnt].to_f > 33 && consensus_info[:med_spread_five_prcnt].to_f < 40

						consensus_info[:med_spread_five_rating] = "cold"

					elsif consensus_info[:med_spread_five_prcnt].to_f >= 40 && consensus_info[:med_spread_five_prcnt].to_f < 60

						consensus_info[:med_spread_five_rating] = "choppy"

					elsif consensus_info[:med_spread_five_prcnt].to_f >= 60 && consensus_info[:med_spread_five_prcnt].to_f < 75

						consensus_info[:med_spread_five_rating] = "hot"

					elsif consensus_info[:med_spread_five_prcnt].to_f >= 75

						consensus_info[:med_spread_five_rating] = "on fire"

					end
				else

					consensus_info[:med_spread_five_rating] = "none"
					consensus_info[:med_spread_five_prcnt] = "none"


				end

				if (med_spread_ten_wins + med_spread_ten_losses) != 0

					consensus_info[:med_spread_ten_prcnt] = ((med_spread_ten_wins.to_f/(med_spread_ten_wins + med_spread_ten_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:med_spread_ten_prcnt].to_f <= 33.0

						consensus_info[:med_spread_ten_rating] = "frigid"

					elsif consensus_info[:med_spread_ten_prcnt].to_f > 33 && consensus_info[:med_spread_ten_prcnt].to_f < 40

						consensus_info[:med_spread_ten_rating] = "cold"

					elsif consensus_info[:med_spread_ten_prcnt].to_f >= 40 && consensus_info[:med_spread_ten_prcnt].to_f < 60

						consensus_info[:med_spread_ten_rating] = "choppy"

					elsif consensus_info[:med_spread_ten_prcnt].to_f >= 60 && consensus_info[:med_spread_ten_prcnt].to_f < 75

						consensus_info[:med_spread_ten_rating] = "hot"

					elsif consensus_info[:med_spread_ten_prcnt].to_f >= 75

						consensus_info[:med_spread_ten_rating] = "on fire"

					end
				
				else

					consensus_info[:med_spread_ten_rating] = "none"
					consensus_info[:med_spread_ten_prcnt] = "none"


				end


				if (med_spread_twenty_wins + med_spread_twenty_losses) != 0

					consensus_info[:med_spread_twenty_prcnt] = ((med_spread_twenty_wins.to_f/(med_spread_twenty_wins + med_spread_twenty_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:med_spread_twenty_prcnt].to_f <= 33.0

						consensus_info[:med_spread_twenty_rating] = "frigid"

					elsif consensus_info[:med_spread_twenty_prcnt].to_f > 33 && consensus_info[:med_spread_twenty_prcnt].to_f < 40

						consensus_info[:med_spread_twenty_rating] = "cold"

					elsif consensus_info[:med_spread_twenty_prcnt].to_f >= 40 && consensus_info[:med_spread_twenty_prcnt].to_f < 60

						consensus_info[:med_spread_twenty_rating] = "choppy"

					elsif consensus_info[:med_spread_twenty_prcnt].to_f >= 60 && consensus_info[:med_spread_twenty_prcnt].to_f < 75

						consensus_info[:med_spread_twenty_rating] = "hot"

					elsif consensus_info[:med_spread_twenty_prcnt].to_f >= 75

						consensus_info[:med_spread_twenty_rating] = "on fire"

					end
				
				else

					consensus_info[:med_spread_twenty_rating] = "none"
					consensus_info[:med_spread_twenty_prcnt] = "none"


				end
				
			elsif f[:spread] == "hi"

				hi_spread_picks.last(5).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1

										else

											hi_spread_five_losses = hi_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										else 

											hi_spread_five_losses = hi_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_five_losses = hi_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											hi_spread_five_losses = hi_spread_five_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											hi_spread_five_losses = hi_spread_five_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										else 

											hi_spread_five_losses = hi_spread_five_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_five_losses = hi_spread_five_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											hi_spread_five_wins = hi_spread_five_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											hi_spread_five_losses = hi_spread_five_losses + 1

										end


									end

								end


							end

						end


					end


				end

				hi_spread_picks.last(10).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1

										else

											hi_spread_ten_losses = hi_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										else 

											hi_spread_ten_losses = hi_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_ten_losses = hi_spread_ten_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											hi_spread_ten_losses = hi_spread_ten_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											hi_spread_ten_losses = hi_spread_ten_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										else 

											hi_spread_ten_losses = hi_spread_ten_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_ten_losses = hi_spread_ten_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											hi_spread_ten_wins = hi_spread_ten_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											hi_spread_ten_losses = hi_spread_ten_losses + 1

										end


									end

								end


							end

						end


					end

				end

				hi_spread_picks.last(20).each do |p|

					team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

					Matchup.all.each do |m|

						if p.matchup_id.to_i == m.id

							if team == m.fav

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i > m.road_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1

										else

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										else 

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f > m.home_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f < m.home_score.to_i 

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1

										end


									end

								end


							elsif team == m.dog

								if m.sport == "MLB"

									if m.fav_field == "home"

										if m.home_score.to_i < m.road_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1

										elsif  m.home_score.to_i > m.road_score.to_i

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1
										
										end

									else

										if m.road_score.to_i > m.home_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										else 

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1


										end


									end

								else

									if m.fav_field == "home"

										if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1


										end

									else

										if m.road_score.to_i + m.spread.to_f < m.home_score.to_i

											hi_spread_twenty_wins = hi_spread_twenty_wins + 1


										elsif m.road_score.to_i + m.spread.to_f > m.home_score.to_i 

											hi_spread_twenty_losses = hi_spread_twenty_losses + 1

										end


									end

								end


							end

						end


					end


				end

				if (hi_spread_five_wins + hi_spread_five_losses) != 0

					consensus_info[:hi_spread_five_prcnt] = ((hi_spread_five_wins.to_f/(hi_spread_five_wins + hi_spread_five_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:hi_spread_five_prcnt].to_f <= 33.0

						consensus_info[:hi_spread_five_rating] = "frigid"

					elsif consensus_info[:hi_spread_five_prcnt].to_f > 33 && consensus_info[:hi_spread_five_prcnt].to_f < 40

						consensus_info[:hi_spread_five_rating] = "cold"

					elsif consensus_info[:hi_spread_five_prcnt].to_f >= 40 && consensus_info[:hi_spread_five_prcnt].to_f < 60

						consensus_info[:hi_spread_five_rating] = "choppy"

					elsif consensus_info[:hi_spread_five_prcnt].to_f >= 60 && consensus_info[:hi_spread_five_prcnt].to_f < 75

						consensus_info[:hi_spread_five_rating] = "hot"

					elsif consensus_info[:hi_spread_five_prcnt].to_f >= 75

						consensus_info[:hi_spread_five_rating] = "on fire"

					end
				else

					consensus_info[:hi_spread_five_rating] = "none"
					consensus_info[:hi_spread_five_prcnt] = "none"


				end

				if (hi_spread_ten_wins + hi_spread_ten_losses) != 0

					consensus_info[:hi_spread_ten_prcnt] = ((hi_spread_ten_wins.to_f/(hi_spread_ten_wins + hi_spread_ten_losses)).round(2) * 100).to_s + "%"

					if consensus_info[:hi_spread_ten_prcnt].to_f <= 33.0

						consensus_info[:hi_spread_ten_rating] = "frigid"

					elsif consensus_info[:hi_spread_ten_prcnt].to_f > 33 && consensus_info[:hi_spread_ten_prcnt].to_f < 40

						consensus_info[:hi_spread_ten_rating] = "cold"

					elsif consensus_info[:hi_spread_ten_prcnt].to_f >= 40 && consensus_info[:hi_spread_ten_prcnt].to_f < 60

						consensus_info[:hi_spread_ten_rating] = "choppy"

					elsif consensus_info[:hi_spread_ten_prcnt].to_f >= 60 && consensus_info[:hi_spread_ten_prcnt].to_f < 75

						consensus_info[:hi_spread_ten_rating] = "hot"

					elsif consensus_info[:hi_spread_ten_prcnt].to_f >= 75

						consensus_info[:hi_spread_ten_rating] = "on fire"

					end
				
				else

					consensus_info[:hi_spread_ten_rating] = "none"
					consensus_info[:hi_spread_ten_prcnt] = "none"


				end


				if (hi_spread_twenty_wins + hi_spread_twenty_losses) != 0

					consensus_info[:hi_spread_twenty_prcnt] = ((hi_spread_twenty_wins.to_f/(hi_spread_twenty_wins + hi_spread_twenty_losses)).round(2) * 100).to_s + "%"	

					if consensus_info[:hi_spread_twenty_prcnt].to_f <= 33.0

						consensus_info[:hi_spread_twenty_rating] = "frigid"

					elsif consensus_info[:hi_spread_twenty_prcnt].to_f > 33 && consensus_info[:hi_spread_twenty_prcnt].to_f < 40

						consensus_info[:hi_spread_twenty_rating] = "cold"

					elsif consensus_info[:hi_spread_twenty_prcnt].to_f >= 40 && consensus_info[:hi_spread_twenty_prcnt].to_f < 60

						consensus_info[:hi_spread_twenty_rating] = "choppy"

					elsif consensus_info[:hi_spread_twenty_prcnt].to_f >= 60 && consensus_info[:hi_spread_twenty_prcnt].to_f < 75

						consensus_info[:hi_spread_twenty_rating] = "hot"

					elsif consensus_info[:hi_spread_twenty_prcnt].to_f >= 75

						consensus_info[:hi_spread_twenty_rating] = "on fire"

					end
				
				else

					consensus_info[:hi_spread_twenty_rating] = "none"
					consensus_info[:hi_spread_twenty_prcnt] = "none"


				end

			end

			@dog_spread_info.push(consensus_info)

		end

		@ovr_obj.each do |x|

			consensus_info = {}

			low_five_wins = 0
			low_five_losses = 0

			med_five_wins = 0
			med_five_losses = 0

			hi_five_wins = 0
			hi_five_losses = 0

			low_ten_wins = 0
			low_ten_losses = 0

			med_ten_wins = 0
			med_ten_losses = 0

			hi_ten_wins = 0
			hi_ten_losses = 0

			low_twenty_wins = 0
			low_twenty_losses = 0

			med_twenty_wins = 0
			med_twenty_losses = 0

			hi_twenty_wins = 0
			hi_twenty_losses = 0

			low_games = []
			med_games = []
			hi_games = []

			User.all.each do |u|

				if u.id == x[:user_id].to_i

					u.picks.each do |p|

						if p.sport == @matchup.sport

							if p.bet_type == "total"

								Matchup.all.each do |m|

									if m.id == p.matchup_id.to_i

										if m.home_score.length != 0

											if m.sport == "MLB"

												if m.total.to_f < 8

													low_games.push(p)

												elsif m.total.to_f >= 8 && m.total.to_f < 10

													med_games.push(p)

												elsif m.total.to_f >= 10

													hi_games.push(p)

												end
											
											elsif m.sport == "NFL"

												if m.total.to_f < 48

													low_games.push(p)

												elsif m.total.to_f >= 48 && m.total.to_f < 53

													med_games.push(p)

												elsif m.total.to_f >= 53

													hi_games.push(p)

												end
											
											elsif m.sport == "NBA"

												if m.total.to_f < 220

													low_games.push(p)

												elsif m.total.to_f >= 220 && m.total.to_f < 228

													med_games.push(p)

												elsif m.total.to_f >= 228

													hi_games.push(p)

												end

											end

										end

									end

								end

							end

						end

					end


				end


			end


			low_games.last(5).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			low_games.last(10).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_five_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_five_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			low_games.last(20).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			med_games.last(5).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			med_games.last(10).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_five_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			med_games.last(20).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			hi_games.last(5).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			hi_games.last(10).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			hi_games.last(20).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			if (low_five_wins + low_five_losses) !=0

				consensus_info[:low_last_five_prcnt] = (((low_five_wins.to_f/(low_five_wins + low_five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:low_last_five_prcnt].to_f <= 33.0

					consensus_info[:low_last_five_rating] = "frigid"


				elsif consensus_info[:low_last_five_prcnt].to_f > 33 && consensus_info[:low_last_five_prcnt].to_f < 40

					consensus_info[:low_last_five_rating] = "cold"

				elsif consensus_info[:low_last_five_prcnt].to_f >=  40 && consensus_info[:low_last_five_prcnt].to_f < 60

					consensus_info[:low_last_five_rating] = "choppy"

				elsif consensus_info[:low_last_five_prcnt].to_f >=  60 && consensus_info[:low_last_five_prcnt].to_f < 75

						consensus_info[:low_last_five_rating] = "hot"

				elsif consensus_info[:low_last_five_prcnt].to_f >= 75
						
						consensus_info[:low_last_five_rating] = "on fire"


				end
			
			else

				consensus_info[:low_last_five_prcnt] = "none"
				consensus_info[:low_last_five_rating] = "none"


			end

			if (med_five_wins + med_five_losses) !=0

				consensus_info[:med_last_five_prcnt] = (((med_five_wins.to_f/(med_five_wins + med_five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:med_last_five_prcnt].to_f <= 33.0

					consensus_info[:med_last_five_rating] = "frigid"


				elsif consensus_info[:med_last_five_prcnt].to_f > 33 && consensus_info[:med_last_five_prcnt].to_f < 40

					consensus_info[:med_last_five_rating] = "cold"

				elsif consensus_info[:med_last_five_prcnt].to_f >=  40 && consensus_info[:med_last_five_prcnt].to_f < 59

					consensus_info[:med_last_five_rating] = "choppy"

				elsif consensus_info[:med_last_five_prcnt].to_f >=  60 && consensus_info[:med_last_five_prcnt].to_f < 75

						consensus_info[:med_last_five_rating] = "hot"

				elsif consensus_info[:med_last_five_prcnt].to_f >= 75
						
						consensus_info[:med_last_five_rating] = "on fire"


				end
			
			else

				consensus_info[:med_last_five_prcnt] = "none"
				consensus_info[:med_last_five_rating] = "none"


			end

			if (hi_five_wins + hi_five_losses) !=0

				consensus_info[:hi_last_five_prcnt] = (((hi_five_wins.to_f/(hi_five_wins + hi_five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:hi_last_five_prcnt].to_f <= 33.0

					consensus_info[:hi_last_five_rating] = "frigid"

				elsif consensus_info[:hi_last_five_prcnt].to_f > 33 && consensus_info[:hi_last_five_prcnt].to_f < 40

					consensus_info[:hi_last_five_rating] = "cold"

				elsif consensus_info[:hi_last_five_prcnt].to_f >=  40 && consensus_info[:hi_last_five_prcnt].to_f < 60

					consensus_info[:hi_last_five_rating] = "choppy"

				elsif consensus_info[:hi_last_five_prcnt].to_f >=  60 && consensus_info[:hi_last_five_prcnt].to_f < 75

						consensus_info[:hi_last_five_rating] = "hot"

				elsif consensus_info[:hi_last_five_prcnt].to_f >= 75

						
						consensus_info[:hi_last_five_rating] = "on fire"


				end
			
			else

				consensus_info[:hi_last_five_prcnt] = "none"
				consensus_info[:hi_last_five_rating] = "none"


			end

			if (low_ten_wins + low_ten_losses) !=0

				consensus_info[:low_last_ten_prcnt] = (((low_ten_wins.to_f/(low_ten_wins + low_ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:low_last_ten_prcnt].to_f <= 33.0

					consensus_info[:low_last_ten_rating] = "frigid"


				elsif consensus_info[:low_last_ten_prcnt].to_f > 33 && consensus_info[:low_last_ten_prcnt].to_f < 40

					consensus_info[:low_last_ten_rating] = "cold"

				elsif consensus_info[:low_last_ten_prcnt].to_f >=  40 && consensus_info[:low_last_ten_prcnt].to_f < 60

					consensus_info[:low_last_ten_rating] = "choppy"

				elsif consensus_info[:low_last_ten_prcnt].to_f >=  60 && consensus_info[:low_last_ten_prcnt].to_f < 75

						consensus_info[:low_last_ten_rating] = "hot"

				elsif consensus_info[:low_last_ten_prcnt].to_f >= 75

						
						consensus_info[:low_last_ten_rating] = "on fire"


				end


			
			else

				consensus_info[:low_last_ten_prcnt] = "none"
				consensus_info[:low_last_ten_rating] = "none"


			end

			if (med_ten_wins + med_ten_losses) !=0

				consensus_info[:med_last_ten_prcnt] = (((med_ten_wins.to_f/(med_ten_wins + med_ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:med_last_ten_prcnt].to_f <= 33.0

					consensus_info[:med_last_ten_rating] = "frigid"


				elsif consensus_info[:med_last_ten_prcnt].to_f > 33 && consensus_info[:med_last_ten_prcnt].to_f < 40

					consensus_info[:med_last_ten_rating] = "cold"

				elsif consensus_info[:med_last_ten_prcnt].to_f >=  40 && consensus_info[:med_last_ten_prcnt].to_f < 60

					consensus_info[:med_last_ten_rating] = "choppy"

				elsif consensus_info[:med_last_ten_prcnt].to_f >=  60 && consensus_info[:med_last_ten_prcnt].to_f < 75

						consensus_info[:med_last_ten_rating] = "hot"

				elsif consensus_info[:med_last_ten_prcnt].to_f >= 75
						
						consensus_info[:med_last_ten_rating] = "on fire"


				end
			
			else

				consensus_info[:med_last_ten_prcnt] = "none"
				consensus_info[:med_last_ten_rating] = "none"


			end

			if (hi_ten_wins + hi_ten_losses) !=0

				consensus_info[:hi_last_ten_prcnt] = (((hi_ten_wins.to_f/(hi_ten_wins + hi_ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:hi_last_ten_prcnt].to_f <= 33.0

					consensus_info[:hi_last_ten_rating] = "frigid"


				elsif consensus_info[:hi_last_ten_prcnt].to_f > 33 && consensus_info[:hi_last_ten_prcnt].to_f < 40

					consensus_info[:hi_last_ten_rating] = "cold"

				elsif consensus_info[:hi_last_ten_prcnt].to_f >=  40 && consensus_info[:hi_last_ten_prcnt].to_f < 60

					consensus_info[:hi_last_ten_rating] = "choppy"

				elsif consensus_info[:hi_last_ten_prcnt].to_f >=  60 && consensus_info[:hi_last_ten_prcnt].to_f < 75

						consensus_info[:hi_last_ten_rating] = "hot"

				elsif consensus_info[:hi_last_ten_prcnt].to_f >= 75
						
						consensus_info[:hi_last_ten_rating] = "on fire"


				end
			
			else

				consensus_info[:hi_last_ten_prcnt] = "none"
				consensus_info[:hi_last_ten_rating] = "none"


			end

			if (low_twenty_wins + low_twenty_losses) !=0

				consensus_info[:low_last_twenty_prcnt] = (((low_twenty_wins.to_f/(low_twenty_wins + low_twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:low_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:low_last_twenty_rating] = "frigid"


				elsif consensus_info[:low_last_twenty_prcnt].to_f > 33 && consensus_info[:low_last_twenty_prcnt].to_f < 40

					consensus_info[:low_last_twenty_rating] = "cold"

				elsif consensus_info[:low_last_twenty_prcnt].to_f >=  40 && consensus_info[:low_last_twenty_prcnt].to_f < 60

					consensus_info[:low_last_twenty_rating] = "choppy"

				elsif consensus_info[:low_last_twenty_prcnt].to_f >=  60 && consensus_info[:low_last_twenty_prcnt].to_f < 75

						consensus_info[:low_last_twenty_rating] = "hot"

				elsif consensus_info[:low_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:low_last_twenty_rating] = "on fire"


				end
			
			else

				consensus_info[:low_last_twenty_prcnt] = "none"
				consensus_info[:low_last_twenty_rating] = "none"


			end

			if (med_twenty_wins + med_twenty_losses) !=0

				consensus_info[:med_last_twenty_prcnt] = (((med_twenty_wins.to_f/(med_twenty_wins + med_twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:med_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:med_last_twenty_rating] = "frigid"


				elsif consensus_info[:med_last_twenty_prcnt].to_f > 33 && consensus_info[:med_last_twenty_prcnt].to_f < 40

					consensus_info[:med_last_twenty_rating] = "cold"

				elsif consensus_info[:med_last_twenty_prcnt].to_f >=  40 && consensus_info[:med_last_twenty_prcnt].to_f < 60

					consensus_info[:med_last_twenty_rating] = "choppy"

				elsif consensus_info[:med_last_twenty_prcnt].to_f >=  60 && consensus_info[:med_last_twenty_prcnt].to_f < 75

						consensus_info[:med_last_twenty_rating] = "hot"

				elsif consensus_info[:med_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:med_last_twenty_rating] = "on fire"


				end
			
			else

				consensus_info[:med_last_twenty_prcnt] = "none"
				consensus_info[:med_last_twenty_rating] = "none"


			end

			if (hi_twenty_wins + hi_twenty_losses) !=0

				consensus_info[:hi_last_twenty_prcnt] = (((hi_twenty_wins.to_f/(hi_twenty_wins + hi_twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:hi_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:hi_last_twenty_rating] = "frigid"


				elsif consensus_info[:hi_last_twenty_prcnt].to_f > 33 && consensus_info[:hi_last_twenty_prcnt].to_f < 40

					consensus_info[:hi_last_twenty_rating] = "cold"

				elsif consensus_info[:hi_last_twenty_prcnt].to_f >=  40 && consensus_info[:hi_last_twenty_prcnt].to_f < 60

					consensus_info[:hi_last_twenty_rating] = "choppy"

				elsif consensus_info[:hi_last_twenty_prcnt].to_f >=  60 && consensus_info[:hi_last_twenty_prcnt].to_f < 75

						consensus_info[:hi_last_twenty_rating] = "hot"

				elsif consensus_info[:hi_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:hi_last_twenty_rating] = "on fire"


				end
			
			else

				consensus_info[:hi_last_twenty_prcnt] = "none"
				consensus_info[:hi_last_twenty_rating] = "none"


			end

			@ovr_spread_info.push(consensus_info)

		end

		@und_obj.each do |x|

			consensus_info = {}

			low_five_wins = 0
			low_five_losses = 0

			med_five_wins = 0
			med_five_losses = 0

			hi_five_wins = 0
			hi_five_losses = 0

			low_ten_wins = 0
			low_ten_losses = 0

			med_ten_wins = 0
			med_ten_losses = 0

			hi_ten_wins = 0
			hi_ten_losses = 0

			low_twenty_wins = 0
			low_twenty_losses = 0

			med_twenty_wins = 0
			med_twenty_losses = 0

			hi_twenty_wins = 0
			hi_twenty_losses = 0

			low_games = []
			med_games = []
			hi_games = []

			User.all.each do |u|

				if u.id == x[:user_id].to_i

					u.picks.each do |p|

						if p.sport == @matchup.sport

							if p.bet_type == "total"

								Matchup.all.each do |m|

									if m.id == p.matchup_id.to_i

										if m.home_score.length != 0

											if m.sport == "MLB"

												if m.total.to_f < 8

													low_games.push(p)

												elsif m.total.to_f >= 8 && m.total.to_f < 10

													med_games.push(p)

												elsif m.total.to_f >= 10

													hi_games.push(p)

												end
											
											elsif m.sport == "NFL"

												if m.total.to_f < 48

													low_games.push(p)

												elsif m.total.to_f >= 48 && m.total.to_f < 53

													med_games.push(p)

												elsif m.total.to_f >= 53

													hi_games.push(p)

												end
											
											elsif m.sport == "NBA"

												if m.total.to_f < 220

													low_games.push(p)

												elsif m.total.to_f >= 220 && m.total.to_f < 228

													med_games.push(p)

												elsif m.total.to_f >= 228

													hi_games.push(p)

												end

											end

										end

									end

								end

							end

						end

					end


				end


			end


			low_games.last(5).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			low_games.last(10).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_five_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			low_games.last(20).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			med_games.last(5).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			med_games.last(10).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_five_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			med_games.last(20).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			hi_games.last(5).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_five_wins = low_five_wins + 1
							
									else 
			
										low_five_losses = low_five_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_five_wins = med_five_wins + 1
							
									else 
			
										med_five_losses = med_five_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_five_wins = hi_five_wins + 1
							
									else 
			
										hi_five_losses = hi_five_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			hi_games.last(10).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_five_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_ten_wins = low_ten_wins + 1
							
									else 
			
										low_ten_losses = low_ten_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_ten_wins = med_ten_wins + 1
							
									else 
			
										med_ten_losses = med_ten_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_ten_wins = hi_ten_wins + 1
							
									else 
			
										hi_ten_losses = hi_ten_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			hi_games.last(20).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						team = (g.selection.slice(0..(g.selection.index(' ')))).delete_suffix(" ")

						if m.sport == "MLB"

							if team == "O"

								if m.total.to_f < 8

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 8

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 8 && m.total.to_f < 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 10

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end


							end


						elsif m.sport == "NFL"

							if team == "O"

								if m.total.to_f < 48

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 48

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 48 && m.total.to_f < 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 53

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end 

						elsif m.sport == "NBA"

							if team == "O"

								if m.total.to_f < 220

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f < m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							elsif team == "U"

								if m.total.to_f < 220

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										low_twenty_wins = low_twenty_wins + 1
							
									else 
			
										low_twenty_losses = low_twenty_losses + 1

									end

								elsif m.total.to_f >= 220 && m.total.to_f < 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										med_twenty_wins = med_twenty_wins + 1
							
									else 
			
										med_twenty_losses = med_twenty_losses + 1

									end

								elsif m.total.to_f >= 228

									if m.total.to_f > m.home_score.to_i + m.road_score.to_i

										hi_twenty_wins = hi_twenty_wins + 1
							
									else 
			
										hi_twenty_losses = hi_twenty_losses + 1

									end

								end

							end

						end			


					end


				end

			end

			if (low_five_wins + low_five_losses) !=0

				consensus_info[:low_last_five_prcnt] = (((low_five_wins.to_f/(low_five_wins + low_five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:low_last_five_prcnt].to_f <= 33.0

					consensus_info[:low_last_five_rating] = "frigid"


				elsif consensus_info[:low_last_five_prcnt].to_f > 33 && consensus_info[:low_last_five_prcnt].to_f < 40

					consensus_info[:low_last_five_rating] = "cold"

				elsif consensus_info[:low_last_five_prcnt].to_f >=  40 && consensus_info[:low_last_five_prcnt].to_f < 60

					consensus_info[:low_last_five_rating] = "choppy"

				elsif consensus_info[:low_last_five_prcnt].to_f >=  60 && consensus_info[:low_last_five_prcnt].to_f < 75

						consensus_info[:low_last_five_rating] = "hot"

				elsif consensus_info[:low_last_five_prcnt].to_f >= 75
						
						consensus_info[:low_last_five_rating] = "on fire"


				end
			
			else

				consensus_info[:low_last_five_prcnt] = "none"
				consensus_info[:low_last_five_rating] = "none"


			end

			if (med_five_wins + med_five_losses) !=0

				consensus_info[:med_last_five_prcnt] = (((med_five_wins.to_f/(med_five_wins + med_five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:med_last_five_prcnt].to_f <= 33.0

					consensus_info[:med_last_five_rating] = "frigid"


				elsif consensus_info[:med_last_five_prcnt].to_f > 33 && consensus_info[:med_last_five_prcnt].to_f < 40

					consensus_info[:med_last_five_rating] = "cold"

				elsif consensus_info[:med_last_five_prcnt].to_f >=  40 && consensus_info[:med_last_five_prcnt].to_f < 59

					consensus_info[:med_last_five_rating] = "choppy"

				elsif consensus_info[:med_last_five_prcnt].to_f >=  60 && consensus_info[:med_last_five_prcnt].to_f < 75

						consensus_info[:med_last_five_rating] = "hot"

				elsif consensus_info[:med_last_five_prcnt].to_f >= 75
						
						consensus_info[:med_last_five_rating] = "on fire"


				end
			
			else

				consensus_info[:med_last_five_prcnt] = "none"
				consensus_info[:med_last_five_rating] = "none"


			end

			if (hi_five_wins + hi_five_losses) !=0

				consensus_info[:hi_last_five_prcnt] = (((hi_five_wins.to_f/(hi_five_wins + hi_five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:hi_last_five_prcnt].to_f <= 33.0

					consensus_info[:hi_last_five_rating] = "frigid"

				elsif consensus_info[:hi_last_five_prcnt].to_f > 33 && consensus_info[:hi_last_five_prcnt].to_f < 40

					consensus_info[:hi_last_five_rating] = "cold"

				elsif consensus_info[:hi_last_five_prcnt].to_f >=  40 && consensus_info[:hi_last_five_prcnt].to_f < 60

					consensus_info[:hi_last_five_rating] = "choppy"

				elsif consensus_info[:hi_last_five_prcnt].to_f >=  60 && consensus_info[:hi_last_five_prcnt].to_f < 75

						consensus_info[:hi_last_five_rating] = "hot"

				elsif consensus_info[:hi_last_five_prcnt].to_f >= 75

						
						consensus_info[:hi_last_five_rating] = "on fire"


				end
			
			else

				consensus_info[:hi_last_five_prcnt] = "none"
				consensus_info[:hi_last_five_rating] = "none"


			end

			if (low_ten_wins + low_ten_losses) !=0

				consensus_info[:low_last_ten_prcnt] = (((low_ten_wins.to_f/(low_ten_wins + low_ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:low_last_ten_prcnt].to_f <= 33.0

					consensus_info[:low_last_ten_rating] = "frigid"


				elsif consensus_info[:low_last_ten_prcnt].to_f > 33 && consensus_info[:low_last_ten_prcnt].to_f < 40

					consensus_info[:low_last_ten_rating] = "cold"

				elsif consensus_info[:low_last_ten_prcnt].to_f >=  40 && consensus_info[:low_last_ten_prcnt].to_f < 60

					consensus_info[:low_last_ten_rating] = "choppy"

				elsif consensus_info[:low_last_ten_prcnt].to_f >=  60 && consensus_info[:low_last_ten_prcnt].to_f < 75

						consensus_info[:low_last_ten_rating] = "hot"

				elsif consensus_info[:low_last_ten_prcnt].to_f >= 75

						
						consensus_info[:low_last_ten_rating] = "on fire"


				end


			
			else

				consensus_info[:low_last_ten_prcnt] = "none"
				consensus_info[:low_last_ten_rating] = "none"


			end

			if (med_ten_wins + med_ten_losses) !=0

				consensus_info[:med_last_ten_prcnt] = (((med_ten_wins.to_f/(med_ten_wins + med_ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:med_last_ten_prcnt].to_f <= 33.0

					consensus_info[:med_last_ten_rating] = "frigid"


				elsif consensus_info[:med_last_ten_prcnt].to_f > 33 && consensus_info[:med_last_ten_prcnt].to_f < 40

					consensus_info[:med_last_ten_rating] = "cold"

				elsif consensus_info[:med_last_ten_prcnt].to_f >=  40 && consensus_info[:med_last_ten_prcnt].to_f < 60

					consensus_info[:med_last_ten_rating] = "choppy"

				elsif consensus_info[:med_last_ten_prcnt].to_f >=  60 && consensus_info[:med_last_ten_prcnt].to_f < 75

						consensus_info[:med_last_ten_rating] = "hot"

				elsif consensus_info[:med_last_ten_prcnt].to_f >= 75
						
						consensus_info[:med_last_ten_rating] = "on fire"


				end
			
			else

				consensus_info[:med_last_ten_prcnt] = "none"
				consensus_info[:med_last_ten_rating] = "none"


			end

			if (hi_ten_wins + hi_ten_losses) !=0

				consensus_info[:hi_last_ten_prcnt] = (((hi_ten_wins.to_f/(hi_ten_wins + hi_ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:hi_last_ten_prcnt].to_f <= 33.0

					consensus_info[:hi_last_ten_rating] = "frigid"


				elsif consensus_info[:hi_last_ten_prcnt].to_f > 33 && consensus_info[:hi_last_ten_prcnt].to_f < 40

					consensus_info[:hi_last_ten_rating] = "cold"

				elsif consensus_info[:hi_last_ten_prcnt].to_f >=  40 && consensus_info[:hi_last_ten_prcnt].to_f < 60

					consensus_info[:hi_last_ten_rating] = "choppy"

				elsif consensus_info[:hi_last_ten_prcnt].to_f >=  60 && consensus_info[:hi_last_ten_prcnt].to_f < 75

						consensus_info[:hi_last_ten_rating] = "hot"

				elsif consensus_info[:hi_last_ten_prcnt].to_f >= 75
						
						consensus_info[:hi_last_ten_rating] = "on fire"


				end
			
			else

				consensus_info[:hi_last_ten_prcnt] = "none"
				consensus_info[:hi_last_ten_rating] = "none"


			end

			if (low_twenty_wins + low_twenty_losses) !=0

				consensus_info[:low_last_twenty_prcnt] = (((low_twenty_wins.to_f/(low_twenty_wins + low_twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:low_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:low_last_twenty_rating] = "frigid"


				elsif consensus_info[:low_last_twenty_prcnt].to_f > 33 && consensus_info[:low_last_twenty_prcnt].to_f < 40

					consensus_info[:low_last_twenty_rating] = "cold"

				elsif consensus_info[:low_last_twenty_prcnt].to_f >=  40 && consensus_info[:low_last_twenty_prcnt].to_f < 60

					consensus_info[:low_last_twenty_rating] = "choppy"

				elsif consensus_info[:low_last_twenty_prcnt].to_f >=  60 && consensus_info[:low_last_twenty_prcnt].to_f < 75

						consensus_info[:low_last_twenty_rating] = "hot"

				elsif consensus_info[:low_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:low_last_twenty_rating] = "on fire"


				end
			
			else

				consensus_info[:low_last_twenty_prcnt] = "none"
				consensus_info[:low_last_twenty_rating] = "none"


			end

			if (med_twenty_wins + med_twenty_losses) !=0

				consensus_info[:med_last_twenty_prcnt] = (((med_twenty_wins.to_f/(med_twenty_wins + med_twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:med_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:med_last_twenty_rating] = "frigid"


				elsif consensus_info[:med_last_twenty_prcnt].to_f > 33 && consensus_info[:med_last_twenty_prcnt].to_f < 40

					consensus_info[:med_last_twenty_rating] = "cold"

				elsif consensus_info[:med_last_twenty_prcnt].to_f >=  40 && consensus_info[:med_last_twenty_prcnt].to_f < 60

					consensus_info[:med_last_twenty_rating] = "choppy"

				elsif consensus_info[:med_last_twenty_prcnt].to_f >=  60 && consensus_info[:med_last_twenty_prcnt].to_f < 75

						consensus_info[:med_last_twenty_rating] = "hot"

				elsif consensus_info[:med_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:med_last_twenty_rating] = "on fire"


				end
			
			else

				consensus_info[:med_last_twenty_prcnt] = "none"
				consensus_info[:med_last_twenty_rating] = "none"


			end

			if (hi_twenty_wins + hi_twenty_losses) !=0

				consensus_info[:hi_last_twenty_prcnt] = (((hi_twenty_wins.to_f/(hi_twenty_wins + hi_twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:hi_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:hi_last_twenty_rating] = "frigid"


				elsif consensus_info[:hi_last_twenty_prcnt].to_f > 33 && consensus_info[:hi_last_twenty_prcnt].to_f < 40

					consensus_info[:hi_last_twenty_rating] = "cold"

				elsif consensus_info[:hi_last_twenty_prcnt].to_f >=  40 && consensus_info[:hi_last_twenty_prcnt].to_f < 60

					consensus_info[:hi_last_twenty_rating] = "choppy"

				elsif consensus_info[:hi_last_twenty_prcnt].to_f >=  60 && consensus_info[:hi_last_twenty_prcnt].to_f < 75

						consensus_info[:hi_last_twenty_rating] = "hot"

				elsif consensus_info[:hi_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:hi_last_twenty_rating] = "on fire"


				end
			
			else

				consensus_info[:hi_last_twenty_prcnt] = "none"
				consensus_info[:hi_last_twenty_rating] = "none"


			end

			@und_spread_info.push(consensus_info)

		end

	end

	def choice_stats

		@favs_obj.each do |x|

			consensus_info = {}

			five_wins = 0
			five_losses = 0

			ten_wins = 0
			ten_losses = 0

			twenty_wins = 0
			twenty_losses = 0

			user_games = []

			User.all.each do |u|

				if u.id == x[:user_id].to_i

					u.picks.each do |p|

						if p.sport == @matchup.sport

							if p.bet_type == "side"

								team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

								Matchup.all.each do |m|

									if m.id == p.matchup_id.to_i

										if m.home_score.length != 0

											if team == m.fav

												user_games.push(p)

											end	

										end

									end

								end

							end

						end

					end

				end

			end

			user_games.last(5).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.sport == "MLB"

							if m.fav_field == "home"

								if m.home_score.to_i > m.road_score.to_i

									five_wins = five_wins + 1

								else

									five_losses = five_losses + 1


								end


							else

								if m.home_score.to_i < m.road_score.to_i

									five_wins = five_wins + 1

								else

									five_losses = five_losses + 1


								end


							end


						else

							if m.fav_field == "home"

								if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

									five_wins = five_wins + 1

								elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

									five_losses = five_losses + 1


								end


							else

								if m.home_score.to_i < m.road_score.to_i + m.spread.to_f

									five_wins = five_wins + 1

								else

									five_losses = five_losses + 1


								end


							end


						end

					end

				end

			end

			user_games.last(10).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.sport == "MLB"

							if m.fav_field == "home"

								if m.home_score.to_i > m.road_score.to_i

									ten_wins = ten_wins + 1

								else

									ten_losses = ten_losses + 1


								end


							else

								if m.home_score.to_i < m.road_score.to_i

									ten_wins = ten_wins + 1

								else

									ten_losses = ten_losses + 1


								end


							end


						else

							if m.fav_field == "home"

								if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

									ten_wins = ten_wins + 1

								elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

									ten_losses = ten_losses + 1


								end


							else

								if m.home_score.to_i < m.road_score.to_i + m.spread.to_f

									ten_wins = ten_wins + 1

								else

									ten_losses = ten_losses + 1


								end


							end


						end

					end

				end

			end

			user_games.last(20).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.sport == "MLB"

							if m.fav_field == "home"

								if m.home_score.to_i > m.road_score.to_i

									twenty_wins = twenty_wins + 1

								else

									twenty_losses = twenty_losses + 1


								end


							else

								if m.home_score.to_i < m.road_score.to_i

									twenty_wins = twenty_wins + 1

								else

									twenty_losses = twenty_losses + 1


								end


							end


						else

							if m.fav_field == "home"

								if m.home_score.to_i + m.spread.to_f > m.road_score.to_i

									twenty_wins = twenty_wins + 1

								elsif m.home_score.to_i + m.spread.to_f < m.road_score.to_i

									twenty_losses = twenty_losses + 1


								end


							else

								if m.home_score.to_i < m.road_score.to_i + m.spread.to_f

									twenty_wins = twenty_wins + 1

								else

									twenty_losses = twenty_losses + 1


								end


							end


						end

					end

				end

			end

			if five_wins + five_losses == 0

				consensus_info[:over_all_last_five_prcnt] = "none"
				consensus_info[:last_five_rating] = "none"


			else 


				consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_five_prcnt].to_f <= 33.0

					consensus_info[:last_five_rating] = "frigid"


				elsif consensus_info[:over_all_last_five_prcnt].to_f > 33 && consensus_info[:over_all_last_five_prcnt].to_f < 40

					consensus_info[:last_five_rating] = "cold"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  40 && consensus_info[:over_all_last_five_prcnt].to_f < 60

					consensus_info[:last_five_rating] = "choppy"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  60 && consensus_info[:over_all_last_five_prcnt].to_f < 75

						consensus_info[:last_five_rating] = "hot"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >= 75
						
						consensus_info[:last_five_rating] = "on fire"


				end

			end

			if ten_wins + ten_losses == 0

				consensus_info[:over_all_last_ten_prcnt] = "none"
				consensus_info[:last_ten_rating] = "none"

			else

				consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins.to_f + ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_ten_prcnt].to_f <= 33.0

					consensus_info[:last_ten_rating] = "frigid"


				elsif consensus_info[:over_all_last_ten_prcnt].to_f > 33 && consensus_info[:over_all_last_ten_prcnt].to_f < 40

					consensus_info[:last_ten_rating] = "cold"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  40 && consensus_info[:over_all_last_ten_prcnt].to_f < 60

					consensus_info[:last_ten_rating] = "choppy"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  60 && consensus_info[:over_all_last_ten_prcnt].to_f < 75

						consensus_info[:last_ten_rating] = "hot"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 75
						
						consensus_info[:last_ten_rating] = "on fire"


				end

			end

			if twenty_wins + twenty_losses == 0

				consensus_info[:over_all_last_twenty_prcnt] = "none"
				consensus_info[:last_twenty_rating] = "none"

			else


				consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins.to_f + twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:last_twenty_rating] = "frigid"


				elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 33 && consensus_info[:over_all_last_twenty_prcnt].to_f < 40

					consensus_info[:last_twenty_rating] = "cold"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  40 && consensus_info[:over_all_last_twenty_prcnt].to_f < 60

					consensus_info[:last_twenty_rating] = "choppy"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  60 && consensus_info[:over_all_last_twenty_prcnt].to_f < 75

						consensus_info[:last_twenty_rating] = "hot"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:last_twenty_rating] = "on fire"


				end

			end

			@fav_choice_info.push(consensus_info)

		end

		@dogs_obj.each do |x|

			consensus_info = {}

			five_wins = 0
			five_losses = 0

			ten_wins = 0
			ten_losses = 0

			twenty_wins = 0
			twenty_losses = 0

			user_games = []

			User.all.each do |u|

				if u.id == x[:user_id].to_i

					u.picks.each do |p|

						if p.sport == @matchup.sport

							if p.bet_type == "side"

								team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

								Matchup.all.each do |m|

									if m.id == p.matchup_id.to_i

										if m.home_score.length != 0

											if team == m.dog

												user_games.push(p)

											end	

										end

									end

								end

							end

						end

					end

				end

			end

			user_games.last(5).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.sport == "MLB"

							if m.fav_field == "home"

								if m.home_score.to_i < m.road_score.to_i

									five_wins = five_wins + 1

								else

									five_losses = five_losses + 1


								end


							else

								if m.home_score.to_i > m.road_score.to_i

									five_wins = five_wins + 1

								else

									five_losses = five_losses + 1


								end


							end


						else

							if m.fav_field == "home"

								if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

									five_wins = five_wins + 1

								elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

									five_losses = five_losses + 1


								end


							else

								if m.home_score.to_i > m.road_score.to_i + m.spread.to_f

									five_wins = five_wins + 1

								else

									five_losses = five_losses + 1


								end


							end


						end

					end

				end

			end

			user_games.last(10).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.sport == "MLB"

							if m.fav_field == "home"

								if m.home_score.to_i < m.road_score.to_i

									ten_wins = ten_wins + 1

								else

									ten_losses = ten_losses + 1


								end


							else

								if m.home_score.to_i > m.road_score.to_i

									ten_wins = ten_wins + 1

								else

									ten_losses = ten_losses + 1


								end


							end


						else

							if m.fav_field == "home"

								if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

									ten_wins = ten_wins + 1

								elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

									ten_losses = ten_losses + 1


								end


							else

								if m.home_score.to_i > m.road_score.to_i + m.spread.to_f

									ten_wins = ten_wins + 1

								else

									ten_losses = ten_losses + 1


								end


							end


						end

					end

				end

			end

			user_games.last(20).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.sport == "MLB"

							if m.fav_field == "home"

								if m.home_score.to_i < m.road_score.to_i

									twenty_wins = twenty_wins + 1

								else

									twenty_losses = twenty_losses + 1


								end


							else

								if m.home_score.to_i > m.road_score.to_i

									twenty_wins = twenty_wins + 1

								else

									twenty_losses = twenty_losses + 1


								end


							end


						else

							if m.fav_field == "home"

								if m.home_score.to_i + m.spread.to_f < m.road_score.to_i

									twenty_wins = twenty_wins + 1

								elsif m.home_score.to_i + m.spread.to_f > m.road_score.to_i

									twenty_losses = twenty_losses + 1


								end


							else

								if m.home_score.to_i > m.road_score.to_i + m.spread.to_f

									twenty_wins = twenty_wins + 1

								else

									twenty_losses = twenty_losses + 1


								end


							end


						end

					end

				end

			end


			if five_wins + five_losses == 0

				consensus_info[:over_all_last_five_prcnt] = "none"
				consensus_info[:last_five_rating] = "none"


			else 


				consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_five_prcnt].to_f <= 33.0

					consensus_info[:last_five_rating] = "frigid"


				elsif consensus_info[:over_all_last_five_prcnt].to_f > 33 && consensus_info[:over_all_last_five_prcnt].to_f < 40

					consensus_info[:last_five_rating] = "cold"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  40 && consensus_info[:over_all_last_five_prcnt].to_f < 60

					consensus_info[:last_five_rating] = "choppy"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  60 && consensus_info[:over_all_last_five_prcnt].to_f < 75

						consensus_info[:last_five_rating] = "hot"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >= 75
						
						consensus_info[:last_five_rating] = "on fire"


				end

			end

			if ten_wins + ten_losses == 0

				consensus_info[:over_all_last_ten_prcnt] = "none"
				consensus_info[:last_ten_rating] = "none"

			else

				consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins.to_f + ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_ten_prcnt].to_f <= 33.0

					consensus_info[:last_ten_rating] = "frigid"


				elsif consensus_info[:over_all_last_ten_prcnt].to_f > 33 && consensus_info[:over_all_last_ten_prcnt].to_f < 40

					consensus_info[:last_ten_rating] = "cold"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  40 && consensus_info[:over_all_last_ten_prcnt].to_f < 60

					consensus_info[:last_ten_rating] = "choppy"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  60 && consensus_info[:over_all_last_ten_prcnt].to_f < 75

						consensus_info[:last_ten_rating] = "hot"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 75
						
						consensus_info[:last_ten_rating] = "on fire"


				end

			end

			if twenty_wins + twenty_losses == 0

				consensus_info[:over_all_last_twenty_prcnt] = "none"
				consensus_info[:last_twenty_rating] = "none"

			else


				consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins.to_f + twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:last_twenty_rating] = "frigid"


				elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 33 && consensus_info[:over_all_last_twenty_prcnt].to_f < 40

					consensus_info[:last_twenty_rating] = "cold"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  40 && consensus_info[:over_all_last_twenty_prcnt].to_f < 60

					consensus_info[:last_twenty_rating] = "choppy"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  60 && consensus_info[:over_all_last_twenty_prcnt].to_f < 75

						consensus_info[:last_twenty_rating] = "hot"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:last_twenty_rating] = "on fire"


				end

			end

			@dog_choice_info.push(consensus_info)

		end

		@ovr_obj.each do |x|

			consensus_info = {}

			five_wins = 0
			five_losses = 0

			ten_wins = 0
			ten_losses = 0

			twenty_wins = 0
			twenty_losses = 0

			user_games = []

			User.all.each do |u|

				if u.id == x[:user_id].to_i

					u.picks.each do |p|

						if p.sport == @matchup.sport

							if p.bet_type == "total"

								team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

								Matchup.all.each do |m|

									if m.id == p.matchup_id.to_i

										if m.home_score.length != 0

											if team == "O"

												user_games.push(p)

											end	

										end

									end

								end

							end

						end

					end

				end

			end

			user_games.last(5).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.total.to_f < m.home_score.to_i + m.road_score.to_i

							five_wins = five_wins + 1


						else

							five_losses = five_losses + 1

						end

					end

				end

			end

			user_games.last(10).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.total.to_f < m.home_score.to_i + m.road_score.to_i

							ten_wins = ten_wins + 1


						else

							ten_losses = ten_losses + 1

						end

					end

				end

			end

			user_games.last(20).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.total.to_f < m.home_score.to_i + m.road_score.to_i

							twenty_wins = twenty_wins + 1


						else

							twenty_losses = twenty_losses + 1

						end

					end

				end

			end

			if five_wins + five_losses == 0

				consensus_info[:over_all_last_five_prcnt] = "none"
				consensus_info[:last_five_rating] = "none"


			else 


				consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_five_prcnt].to_f <= 33.0

					consensus_info[:last_five_rating] = "frigid"


				elsif consensus_info[:over_all_last_five_prcnt].to_f > 33 && consensus_info[:over_all_last_five_prcnt].to_f < 40

					consensus_info[:last_five_rating] = "cold"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  40 && consensus_info[:over_all_last_five_prcnt].to_f < 60

					consensus_info[:last_five_rating] = "choppy"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  60 && consensus_info[:over_all_last_five_prcnt].to_f < 75

						consensus_info[:last_five_rating] = "hot"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >= 75
						
						consensus_info[:last_five_rating] = "on fire"


				end

			end

			if ten_wins + ten_losses == 0

				consensus_info[:over_all_last_ten_prcnt] = "none"
				consensus_info[:last_ten_rating] = "none"

			else

				consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins.to_f + ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_ten_prcnt].to_f <= 33.0

					consensus_info[:last_ten_rating] = "frigid"


				elsif consensus_info[:over_all_last_ten_prcnt].to_f > 33 && consensus_info[:over_all_last_ten_prcnt].to_f < 40

					consensus_info[:last_ten_rating] = "cold"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  40 && consensus_info[:over_all_last_ten_prcnt].to_f < 60

					consensus_info[:last_ten_rating] = "choppy"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  60 && consensus_info[:over_all_last_ten_prcnt].to_f < 75

						consensus_info[:last_ten_rating] = "hot"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 75
						
						consensus_info[:last_ten_rating] = "on fire"


				end

			end

			if twenty_wins + twenty_losses == 0

				consensus_info[:over_all_last_twenty_prcnt] = "none"
				consensus_info[:last_twenty_rating] = "none"

			else


				consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins.to_f + twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:last_twenty_rating] = "frigid"


				elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 33 && consensus_info[:over_all_last_twenty_prcnt].to_f < 40

					consensus_info[:last_twenty_rating] = "cold"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  40 && consensus_info[:over_all_last_twenty_prcnt].to_f < 60

					consensus_info[:last_twenty_rating] = "choppy"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  60 && consensus_info[:over_all_last_twenty_prcnt].to_f < 75

						consensus_info[:last_twenty_rating] = "hot"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:last_twenty_rating] = "on fire"


				end

			end

			@ovr_choice_info.push(consensus_info)

		end

		@und_obj.each do |x|

			consensus_info = {}

			five_wins = 0
			five_losses = 0

			ten_wins = 0
			ten_losses = 0

			twenty_wins = 0
			twenty_losses = 0

			user_games = []

			User.all.each do |u|

				if u.id == x[:user_id].to_i

					u.picks.each do |p|

						if p.sport == @matchup.sport

							if p.bet_type == "total"

								team = (p.selection.slice(0..(p.selection.index(' ')))).delete_suffix(" ")

								Matchup.all.each do |m|

									if m.id == p.matchup_id.to_i

										if m.home_score.length != 0

											if team == "U"

												user_games.push(p)

											end	

										end

									end

								end

							end

						end

					end

				end

			end

			user_games.last(5).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.total.to_f < m.home_score.to_i + m.road_score.to_i

							five_wins = five_wins + 1


						else

							five_losses = five_losses + 1

						end

					end

				end

			end

			user_games.last(10).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.total.to_f < m.home_score.to_i + m.road_score.to_i

							ten_wins = ten_wins + 1


						else

							ten_losses = ten_losses + 1

						end

					end

				end

			end

			user_games.last(20).each do |g|

				Matchup.all.each do |m|

					if g.matchup_id.to_i == m.id

						if m.total.to_f < m.home_score.to_i + m.road_score.to_i

							twenty_wins = twenty_wins + 1


						else

							twenty_losses = twenty_losses + 1

						end

					end

				end

			end


			if five_wins + five_losses == 0

				consensus_info[:over_all_last_five_prcnt] = "none"
				consensus_info[:last_five_rating] = "none"


			else 


				consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_five_prcnt].to_f <= 33.0

					consensus_info[:last_five_rating] = "frigid"


				elsif consensus_info[:over_all_last_five_prcnt].to_f > 33 && consensus_info[:over_all_last_five_prcnt].to_f < 40

					consensus_info[:last_five_rating] = "cold"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  40 && consensus_info[:over_all_last_five_prcnt].to_f < 60

					consensus_info[:last_five_rating] = "choppy"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >=  60 && consensus_info[:over_all_last_five_prcnt].to_f < 75

						consensus_info[:last_five_rating] = "hot"

				elsif consensus_info[:over_all_last_five_prcnt].to_f >= 75
						
						consensus_info[:last_five_rating] = "on fire"


				end

			end

			if ten_wins + ten_losses == 0

				consensus_info[:over_all_last_ten_prcnt] = "none"
				consensus_info[:last_ten_rating] = "none"

			else

				consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins.to_f + ten_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_ten_prcnt].to_f <= 33.0

					consensus_info[:last_ten_rating] = "frigid"


				elsif consensus_info[:over_all_last_ten_prcnt].to_f > 33 && consensus_info[:over_all_last_ten_prcnt].to_f < 40

					consensus_info[:last_ten_rating] = "cold"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  40 && consensus_info[:over_all_last_ten_prcnt].to_f < 60

					consensus_info[:last_ten_rating] = "choppy"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  60 && consensus_info[:over_all_last_ten_prcnt].to_f < 75

						consensus_info[:last_ten_rating] = "hot"

				elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 75
						
						consensus_info[:last_ten_rating] = "on fire"


				end

			end

			if twenty_wins + twenty_losses == 0

				consensus_info[:over_all_last_twenty_prcnt] = "none"
				consensus_info[:last_twenty_rating] = "none"

			else


				consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins.to_f + twenty_losses)) * 100).round(2)).to_s + "%"

				if consensus_info[:over_all_last_twenty_prcnt].to_f <= 33.0

					consensus_info[:last_twenty_rating] = "frigid"


				elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 33 && consensus_info[:over_all_last_twenty_prcnt].to_f < 40

					consensus_info[:last_twenty_rating] = "cold"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  40 && consensus_info[:over_all_last_twenty_prcnt].to_f < 60

					consensus_info[:last_twenty_rating] = "choppy"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  60 && consensus_info[:over_all_last_twenty_prcnt].to_f < 75

						consensus_info[:last_twenty_rating] = "hot"

				elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 75
						
						consensus_info[:last_twenty_rating] = "on fire"


				end

			end

			@und_choice_info.push(consensus_info)

		end

	end


end

		





	
					

						

							


						
