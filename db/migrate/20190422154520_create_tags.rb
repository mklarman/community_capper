class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|

    	t.string :date
    	t.string :follower_id
    	t.string :star_id
    	t.string :situation
    	t.string :brand

      t.timestamps
    end
  end
end
