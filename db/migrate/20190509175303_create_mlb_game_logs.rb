class CreateMlbGameLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :mlb_game_logs do |t|

    	t.string :team_id
		t.string :date
		t.string :team_name
		t.string :opp
		t.string :home
		t.string :spread
		t.string :situation
		t.string :team_starting_pitcher
		t.string :opp_starting_pitcher
		t.string :opp_pitcher_throws
		t.string :team_pitcher_throws
		t.string :team_starter_pitches
		t.string :opp_starter_pitches
		t.string :team_bullpen_picthes
		t.string :opp_bullpen_picthes
		t.string :runs_by_opp_starter
		t.string :runs_by_team_starter
		t.string :runs_by_opp_bullpen
		t.string :runs_by_team_bullpen
		t.string :at_bats_for
		t.string :at_bats_against
		t.string :team_hits
		t.string :team_errors
		t.string :opp_hits
		t.string :opp_errors
		t.string :team_runs
		t.string :opp_runs
		t.string :spread_result

      t.timestamps
    end
  end
end
