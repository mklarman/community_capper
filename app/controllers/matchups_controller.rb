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

	end

	def show

		@matchup = Matchup.find_by_id(params[:id])
		@selection = Selection.new


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

		params.require(:matchup).permit(:date, :sport, :fav, :dog, :fav_field, :dog_field, :spread, :fav_ml, :dog_ml, :total, :game_type, :field_type, :road_start_time, :home_start_time, :weather, :home_d, :home_o, :road_d, :road_o, :home_pitcher, :away_pitcher, :home_score, :road_score, :winner)

	end

end

