class CreateMatchups < ActiveRecord::Migration[5.1]
  def change
    create_table :matchups do |t|

    	t.string :date
    	t.string :sport
    	t.string :fav
    	t.string :dog
    	t.string :fav_field
    	t.string :spread
    	t.string :fav_ml
    	t.string :dog_ml
    	t.string :total
    	t.string :start_time
    	t.string :home_score
    	t.string :road_score

      	t.timestamps
    end
  end
end
