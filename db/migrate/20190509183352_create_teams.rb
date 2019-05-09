class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|

    	t.string :sport
    	t.string :city_or_school_name
    	t.string :team_name
    	t.string :div_or_conf
    	t.string :matchup_abbr

      t.timestamps
    end
  end
end
