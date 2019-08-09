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
		@nfl_game_log = NflGameLog.new

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

	def mlb_game_log_params

		params.require(:mlb_game_log).permit(:team_id, :date, :team_name, :opp, :home, :spread, :situation, :team_starting_pitcher, :innings, :opp_starting_pitcher, :opp_pitcher_throws, :team_pitcher_throws, :team_starter_pitches, :opp_starter_pitches, :team_bullpen_picthes, :opp_bullpen_picthes, :runs_by_opp_starter, :runs_by_team_starter, :runs_by_opp_bullpen, :runs_by_team_bullpen, :at_bats_for, :at_bats_against, :team_hits, :team_errors, :opp_hits, :opp_errors, :team_runs, :opp_runs, :spread_result)

	end


end



