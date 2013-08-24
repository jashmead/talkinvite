class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.integer :location_id
      t.text :settings

      t.timestamps
    end
  end
end
