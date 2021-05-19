class CreatePicks < ActiveRecord::Migration[5.1]
  def change
    create_table :picks do |t|

      t.string :user_id
      t.string :date
      t.string :sport
      t.string :matchup_id
      t.string :bet_type
      t.string :selection

      t.timestamps
    end
  end
end
