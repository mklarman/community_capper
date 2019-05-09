class TeamsController < ApplicationController

	def new

		@team = Team.new


	end

	def index

		@teams = Team.all


	end

	def show

		@team = Team.find_by_id(params[:id])

		@mlb_game_log = MlbGameLog.new

	end

	def create

		team = Team.new(team_params)

		if team.save

			redirect_back(fallback_location: users_profile_path)

		else

			redirect_back(fallback_location: new_team_path)

		end

	end

	private

	def team_params

		params.require(:team).permit(:sport, :city_or_school_name, :team_name, :div_or_conf, :matchup_abbr)

	end

end



