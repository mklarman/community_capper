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

	def edit

		@matchup = Matchup.find_by_id(params[:id])
		
		@fav_run_percentage
		@dog_run_percentage

		@fav_pass_percentage
		@dog_pass_percentage

		@fav_run_ag_percentage
		@dog_run_ag_percentage

		@fav_pass_ag_percentage
		@dog_pass_ag_percentage

		@fav_record
		@dog_record

		@fav_rush_for
		@dog_rush_for

		@fav_rush_pos
		@dog_rush_pos

		@fav_rush_ag
		@dog_rush_ag

		@fav_rush_ag_pos
		@dog_rush_ag_pos

		@fav_pass_for
		@dog_pass_for

		@fav_pass_pos
		@dog_pass_pos

		@fav_pass_ag
		@dog_pass_ag

		@fav_pass_ag_pos
		@dog_pass_ag_pos


	end

	def team_stats

		@teams = Team.all

	end

	def last_three

		@teams = Team.all

	end

	def last_ten

		@teams = Team.all

	end

	def last_thirty

		@teams = Team.all

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

