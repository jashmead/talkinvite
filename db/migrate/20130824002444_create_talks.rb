class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :summary
      t.text :description
      t.integer :location_id

      t.timestamps
    end
  end
end
