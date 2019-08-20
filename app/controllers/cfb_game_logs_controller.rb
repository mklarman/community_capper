class CfbGameLogsController < ApplicationController

	def index

		teams = Team.all
		logs = CfbGameLog.all

	end

	def create

		cfb_game_log = CfbGameLog.new(cfb_game_log_params)

		if cfb_game_log.save

			redirect_to teams_path

		else

			redirect_back(fallback_location: teams_path)

		end

	end

	private

	def cfb_game_log_params

		params.require(:cfb_game_log).permit(:team_id, :date, :home, :opp, :spread, :rush_yards_for, :rush_yards_against, :pass_yards_for, :pass_yards_against, :plays_for, :plays_against, :turn_overs, :opp_turn_overs, :sacks_for, :sacks_against, :scoring_plays_for, :scoring_plays_against, :score, :opp_score, :spread_result)

	end
end
