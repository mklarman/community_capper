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
						
						elsif @matchup.fav_ml.to_i >= 160 

							consensus_info[:spread] = "hi"

						end


					else

						if @matchup.spread.to_i < 4

							consensus_info[:spread] = "low"

						elsif @matchup.spread.to_i >= 4 && @matchup.spread.to_i < 8

							consensus_info[:spread] = "med"
						
						elsif @matchup.spread.to_i >= 8

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

	def overall_sport_side

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

			consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

			if consensus_info[:over_all_last_five_prcnt].to_f <= 39.0

				consensus_info[:last_five_rating] = "ice cold"


			elsif consensus_info[:over_all_last_five_prcnt].to_f > 39 && consensus_info[:over_all_last_five_prcnt].to_f < 46

				consensus_info[:last_five_rating] = "cold"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >=  46 && consensus_info[:over_all_last_five_prcnt].to_f < 56

				consensus_info[:last_five_rating] = "choppy"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >=  56 && consensus_info[:over_all_last_five_prcnt].to_f < 65

					consensus_info[:last_five_rating] = "hot"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >= 65
					
					consensus_info[:last_five_rating] = "red hot"


			end

			consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins.to_f + ten_losses)) * 100).round(2)).to_s + "%"

			if consensus_info[:over_all_last_ten_prcnt].to_f <= 39.0

				consensus_info[:last_ten_rating] = "ice cold"


			elsif consensus_info[:over_all_last_ten_prcnt].to_f > 39 && consensus_info[:over_all_last_ten_prcnt].to_f < 46

				consensus_info[:last_ten_rating] = "cold"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  46 && consensus_info[:over_all_last_ten_prcnt].to_f < 56

				consensus_info[:last_ten_rating] = "choppy"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  56 && consensus_info[:over_all_last_ten_prcnt].to_f < 65

					consensus_info[:last_ten_rating] = "hot"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 65
					
					consensus_info[:last_ten_rating] = "red hot"


			end

			consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins.to_f + twenty_losses)) * 100).round(2)).to_s + "%"

			if consensus_info[:over_all_last_twenty_prcnt].to_f <= 39.0

				consensus_info[:last_twenty_rating] = "ice cold"


			elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 39 && consensus_info[:over_all_last_twenty_prcnt].to_f < 46

				consensus_info[:last_twenty_rating] = "cold"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  46 && consensus_info[:over_all_last_twenty_prcnt].to_f < 56

				consensus_info[:last_twenty_rating] = "choppy"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  56 && consensus_info[:over_all_last_twenty_prcnt].to_f < 65

					consensus_info[:last_twenty_rating] = "hot"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 65
					
					consensus_info[:last_twenty_rating] = "red hot"


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

			consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

			if consensus_info[:over_all_last_five_prcnt].to_f <= 39.0

				consensus_info[:last_five_rating] = "ice cold"


			elsif consensus_info[:over_all_last_five_prcnt].to_f > 39 && consensus_info[:over_all_last_five_prcnt].to_f < 46

				consensus_info[:last_five_rating] = "cold"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >=  46 && consensus_info[:over_all_last_five_prcnt].to_f < 56

				consensus_info[:last_five_rating] = "choppy"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >=  56 && consensus_info[:over_all_last_five_prcnt].to_f < 65

					consensus_info[:last_five_rating] = "hot"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >= 65
					
					consensus_info[:last_five_rating] = "red hot"


			end

			consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins + ten_losses)) * 100).round(2)).to_s + "%"

			if consensus_info[:over_all_last_ten_prcnt].to_f <= 39.0

				consensus_info[:last_ten_rating] = "ice cold"


			elsif consensus_info[:over_all_last_ten_prcnt].to_f > 39 && consensus_info[:over_all_last_ten_prcnt].to_f < 46

				consensus_info[:last_ten_rating] = "cold"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  46 && consensus_info[:over_all_last_ten_prcnt].to_f < 56

				consensus_info[:last_ten_rating] = "choppy"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  56 && consensus_info[:over_all_last_ten_prcnt].to_f < 65

					consensus_info[:last_ten_rating] = "hot"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 65
					
					consensus_info[:last_ten_rating] = "red hot"


			end

			consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins + twenty_losses)) * 100).round(2)).to_s + "%"

			if consensus_info[:over_all_last_twenty_prcnt].to_f <= 39.0

				consensus_info[:last_twenty_rating] = "ice cold"


			elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 39 && consensus_info[:over_all_last_twenty_prcnt].to_f < 46

				consensus_info[:last_twenty_rating] = "cold"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  46 && consensus_info[:over_all_last_twenty_prcnt].to_f < 56

				consensus_info[:last_twenty_rating] = "choppy"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  56 && consensus_info[:over_all_last_twenty_prcnt].to_f < 65

					consensus_info[:last_twenty_rating] = "hot"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 65
					
					consensus_info[:last_twenty_rating] = "red hot"


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

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								five_wins = five_wins + 1
							
							else 

								
								five_losses = five_losses + 1


							end

						else

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

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

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								ten_wins = ten_wins + 1
							
							else 

								
								ten_losses = ten_losses + 1


							end

						else

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

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

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								twenty_wins = twenty_wins + 1
							
							else 

								
								twenty_losses = twenty_losses + 1


							end

						else

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

								twenty_wins = twenty_wins + 1

							else

								twenty_losses = twenty_losses + 1

							end

						end


					end


				end

			end

			consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

			if consensus_info[:over_all_last_five_prcnt].to_f <= 39.0

				consensus_info[:last_five_rating] = "ice cold"


			elsif consensus_info[:over_all_last_five_prcnt].to_f > 39 && consensus_info[:over_all_last_five_prcnt].to_f < 46

				consensus_info[:last_five_rating] = "cold"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >=  46 && consensus_info[:over_all_last_five_prcnt].to_f < 56

				consensus_info[:last_five_rating] = "choppy"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >=  56 && consensus_info[:over_all_last_five_prcnt].to_f < 65

					consensus_info[:last_five_rating] = "hot"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >= 65
					
					consensus_info[:last_five_rating] = "red hot"


			end

			consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins + ten_losses)) * 100).round(2)).to_s + "%"


			if consensus_info[:over_all_last_ten_prcnt].to_f <= 39.0

				consensus_info[:last_ten_rating] = "ice cold"


			elsif consensus_info[:over_all_last_ten_prcnt].to_f > 39 && consensus_info[:over_all_last_ten_prcnt].to_f < 46

				consensus_info[:last_ten_rating] = "cold"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  46 && consensus_info[:over_all_last_ten_prcnt].to_f < 56

				consensus_info[:last_ten_rating] = "choppy"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  56 && consensus_info[:over_all_last_ten_prcnt].to_f < 65

					consensus_info[:last_ten_rating] = "hot"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 65
					
					consensus_info[:last_ten_rating] = "red hot"


			end

			consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins + twenty_losses)) * 100).round(2)).to_s + "%"


			if consensus_info[:over_all_last_twenty_prcnt].to_f <= 39.0

				consensus_info[:last_twenty_rating] = "ice cold"


			elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 39 && consensus_info[:over_all_last_twenty_prcnt].to_f < 46

				consensus_info[:last_twenty_rating] = "cold"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  46 && consensus_info[:over_all_last_twenty_prcnt].to_f < 56

				consensus_info[:last_twenty_rating] = "choppy"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  56 && consensus_info[:over_all_last_twenty_prcnt].to_f < 65

					consensus_info[:last_twenty_rating] = "hot"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 65
					
					consensus_info[:last_twenty_rating] = "red hot"


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

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								five_wins = five_wins + 1
							
							else 

								
								five_losses = five_losses + 1


							end

						else

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

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

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								ten_wins = ten_wins + 1
							
							else 

								
								ten_losses = ten_losses + 1


							end

						else

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

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

							if m.total.to_i > m.home_score.to_i + m.road_score.to_i

								twenty_wins = twenty_wins + 1
							
							else 

								
								twenty_losses = twenty_losses + 1


							end

						else

							if m.total.to_i < m.home_score.to_i + m.road_score.to_i

								twenty_wins = twenty_wins + 1

							else

								twenty_losses = twenty_losses + 1

							end

						end


					end


				end

			end

			consensus_info[:over_all_last_five_prcnt] = (((five_wins.to_f/(five_wins + five_losses)) * 100).round(2)).to_s + "%"

			if consensus_info[:over_all_last_five_prcnt].to_f <= 39.0

				consensus_info[:last_five_rating] = "ice cold"


			elsif consensus_info[:over_all_last_five_prcnt].to_f > 39 && consensus_info[:over_all_last_five_prcnt].to_f < 46

				consensus_info[:last_five_rating] = "cold"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >=  46 && consensus_info[:over_all_last_five_prcnt].to_f < 56

				consensus_info[:last_five_rating] = "choppy"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >=  56 && consensus_info[:over_all_last_five_prcnt].to_f < 65

					consensus_info[:last_five_rating] = "hot"

			elsif consensus_info[:over_all_last_five_prcnt].to_f >= 65
					
					consensus_info[:last_five_rating] = "red hot"


			end

			consensus_info[:over_all_last_ten_prcnt] = (((ten_wins.to_f/(ten_wins + ten_losses)) * 100).round(2)).to_s + "%"


			if consensus_info[:over_all_last_ten_prcnt].to_f <= 39.0

				consensus_info[:last_ten_rating] = "ice cold"


			elsif consensus_info[:over_all_last_ten_prcnt].to_f > 39 && consensus_info[:over_all_last_ten_prcnt].to_f < 46

				consensus_info[:last_ten_rating] = "cold"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  46 && consensus_info[:over_all_last_ten_prcnt].to_f < 56

				consensus_info[:last_ten_rating] = "choppy"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >=  56 && consensus_info[:over_all_last_ten_prcnt].to_f < 65

					consensus_info[:last_ten_rating] = "hot"

			elsif consensus_info[:over_all_last_ten_prcnt].to_f >= 65
					
					consensus_info[:last_ten_rating] = "red hot"


			end

			consensus_info[:over_all_last_twenty_prcnt] = (((twenty_wins.to_f/(twenty_wins + twenty_losses)) * 100).round(2)).to_s + "%"


			if consensus_info[:over_all_last_twenty_prcnt].to_f <= 39.0

				consensus_info[:last_twenty_rating] = "ice cold"


			elsif consensus_info[:over_all_last_twenty_prcnt].to_f > 39 && consensus_info[:over_all_last_twenty_prcnt].to_f < 46

				consensus_info[:last_twenty_rating] = "cold"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  46 && consensus_info[:over_all_last_twenty_prcnt].to_f < 56

				consensus_info[:last_twenty_rating] = "choppy"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >=  56 && consensus_info[:over_all_last_twenty_prcnt].to_f < 65

					consensus_info[:last_twenty_rating] = "hot"

			elsif consensus_info[:over_all_last_twenty_prcnt].to_f >= 65
					
					consensus_info[:last_twenty_rating] = "red hot"


			end

			@und_bettors_info.push(consensus_info)
			


		end

		
	end



	
end



				

					

						

							


						
