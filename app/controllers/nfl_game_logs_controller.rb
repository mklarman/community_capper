class NflGameLogsController < ApplicationController

	def index

		@nfl_teams = []

		@logs = NflGameLog.all

		Team.all.each do |t|

			if t.sport == "NFL"

				@nfl_teams.push(t)

			end

		end

	end

	def create

		nfl_game_log = NflGameLog.new(nfl_game_log_params)

		if nfl_game_log.save

			redirect_to teams_path

		else

			redirect_back(fallback_location: teams_path)

		end

	end

	private

	def nfl_game_log_params

		params.require(:nfl_game_log).permit(:team_id, :date, :home, :opp, :spread, :run_plays, :rush_yards_for, :run_plays_against, :rush_yards_against, :pass_plays, :pass_yards_for, :pass_plays_against, :pass_yards_against, :plays_for, :plays_against, :turn_overs, :opp_turn_overs, :sacks_for, :sacks_against, :scoring_plays_for, :scoring_plays_against, :score, :opp_score, :spread_result)

	end
end


