class AddToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :person_id, :integer, { null: nil }
  end
end
