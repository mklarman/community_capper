class CreatePicks < ActiveRecord::Migration[5.1]
  def change
    create_table :picks do |t|

    	t.string :sport
    	t.string :cat
    	t.string :pick
    	t.string :line
    	t.string :reason
    	t.string :line_movement
    	t.string :consensus
    	t.string :result



      t.timestamps
    end
  end
end
