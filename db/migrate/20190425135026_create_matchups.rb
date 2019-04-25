class CreateMatchups < ActiveRecord::Migration[5.1]
  def change
    create_table :matchups do |t|

    	t.string :date
    	t.string :sport
    	t.string :fav
    	t.string :dog
    	t.string :fav_field
    	t.string :dog_field
    	t.string :spread
    	t.string :fav_ml
    	t.string :dog_ml
    	t.string :total
    	t.string :game_type
    	t.string :field_type
    	t.string :road_start_time
    	t.string :home_start_time
    	t.string :weather
    	t.string :home_d
    	t.string :home_o
    	t.string :road_d
    	t.string :road_o
    	t.string :home_pitcher
    	t.string :away_pitcher
    	t.string :home_score
    	t.string :road_score
    	t.string :winner

      	t.timestamps
    end
  end
end
