class CreateCbbGameLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :cbb_game_logs do |t|

    	t.string :date
    	t.string :opp
    	t.string :home
    	t.string :spread
    	t.string :possessions_for
    	t.string :possessions_against
    	t.string :field_goals_made_for
    	t.string :field_goals_made_against
    	t.string :three_pointers_made
    	t.string :three_pointers_made_against
    	t.string :points_in_the_paint_for
    	t.string :points_in_the_paint_against
    	t.string :rebounds_for
    	t.string :rebounds_against
    	t.string :assists_for
    	t.string :assists_against
    	t.string :steals_for
    	t.string :steals_against
    	t.string :turn_overs_for
    	t.string :opp_turn_overs
    	t.string :score
    	t.string :opp_score
    	t.string :spread_result

      t.timestamps
    end
  end
end
