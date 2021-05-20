class MatchupsController < ApplicationController

	def new
		
		@matchup = Matchup.new

	end

	def create

		matchup = Matchup.new(matchup_params)

		if matchup.save

			redirect_back(fallback_location: users_profile_path)

		else

			redirect_back(fallback_location: new_matchup_path)

		end

	end

	def index

		@matchups = Matchup.all

		@pick = Pick.new

		@nfl_last
		@nba_last
		@mlb_last
		@all_user_picks = []

		current_user.picks.all.each do |p|

			if p.date == @my_date

				@all_user_picks.push(p)


			end



		end

	end

	def show

		@matchup = Matchup.find_by_id(params[:id])
		


	end

	def edit

		@matchup = Matchup.find_by_id(params[:id])
		
	end

	def update

		@matchup = Matchup.find_by_id(params[:id])

		if @matchup.update(matchup_params)

			redirect_back(fallback_location: users_profile_path)
		else

			redirect_back(fallback_location: new_matchup_path)

		end

	end


	private

	def matchup_params

		params.require(:matchup).permit(:date, :sport, :fav, :dog, :fav_field, :spread, :fav_ml, :dog_ml, :total, :start_time, :home_score, :road_score)
		
	end

	def pick_params

		params.require(:pick).permit(:user_id, :sport, :matchup_id, :bet_type, :selection)

	end

end





