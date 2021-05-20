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

	
end
