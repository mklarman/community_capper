class CreateCfbGameLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :cfb_game_logs do |t|

    	t.string :date
    	t.string :home
    	t.string :opp
    	t.string :spread
    	t.string :rush_yards_for
    	t.string :rush_yards_against
    	t.string :pass_yards_for
    	t.string :pass_yards_against
    	t.string :plays_for
    	t.string :plays_against
    	t.string :turn_overs
    	t.string :opp_turn_overs
    	t.string :sacks_for
    	t.string :sacks_against
    	t.string :scoring_plays_for
    	t.string :scoring_plays_against
    	t.string :score
    	t.string :opp_score
    	t.string :spread_result

      t.timestamps
    end
  end
end
