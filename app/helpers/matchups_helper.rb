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

			if m.date == @my_date

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

			if m.date != @my_date && m.home_score.length == 0

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



	
end
