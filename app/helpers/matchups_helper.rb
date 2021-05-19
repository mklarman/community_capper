module MatchupsHelper

	def get_last_sport

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
