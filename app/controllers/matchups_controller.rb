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

	end

	def matchups_list

		@matchup = Matchup.all
		@nfl_matchups = []
		@nba_matchups = []
		@mlb_matchups = []

		@nfl_update = []
		@nba_update = []
		@mlb_update = []
		@my_date


	end

	def show

		@matchup = Matchup.find_by_id(params[:id])

		@favs_obj = []
		@dogs_obj = []
		@ovr_obj = []
		@und_obj = []
		@on_side
		@on_total
		@fav_prcnt
		@dog_prcnt
		@ovr_prcnt
		@und_prcnt
		@matchup_label
		@fav_line
		@dog_line
		@spread_line
		@total_line
		
		@fav_bettors_info = []
		@dog_bettors_info = []
		@ovr_bettors_info = []
		@und_bettors_info = []
		
		@fav_spread_info = []
		@dog_spread_info = []
		@ovr_spread_info = []
		@und_spread_info = []

		@fav_choice_info = []
		@dog_choice_info = []
		@ovr_choice_info = []
		@und_choice_info = []
		


	end

	def edit

		@matchup = Matchup.find_by_id(params[:id])
		
	end

	def update

		@matchup = Matchup.find_by_id(params[:id])

		if @matchup.update(matchup_params)

			redirect_to matchup_list_path(fallback_location: users_profile_path)
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





