class Team < ApplicationRecord
	
	has_many :mlb_game_logs
	has_many :nfl_game_logs
	has_many :cfb_game_logs

end
