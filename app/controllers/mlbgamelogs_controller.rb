class MlbgamelogsController < ApplicationController
	def new

		@mlb_game_log = MlbGameLog.new


	end

	def create

		mlb_game_log = MlbGameLog.new(mlb_game_log_params)

		if mlb_game_log.save

			redirect_to teams_path

		else

			redirect_back(fallback_location: teams_path)

		end

	end

	private

	def mlb_game_log_params

		params.require(:mlb_game_log).permit(:team_id, :date, :team_name, :opp, :home, :spread, :situation, :team_starting_pitcher, :opp_starting_pitcher, :opp_pitcher_throws, :team_pitcher_throws, :team_starter_pitches, :opp_starter_pitches, :team_bullpen_picthes, :opp_bullpen_picthes, :runs_by_opp_starter, :runs_by_team_starter, :runs_by_opp_bullpen, :runs_by_team_bullpen, :at_bats_for, :at_bats_against, :team_hits, :team_errors, :opp_hits, :opp_errors, :team_runs, :opp_runs, :spread_result)

	end
end


		
		
		
		
