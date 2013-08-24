class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.string :screen_name
      t.string :content
      t.integer :location_id

      t.timestamps
    end
  end
end
