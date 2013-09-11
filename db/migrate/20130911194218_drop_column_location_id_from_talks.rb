class DropColumnLocationIdFromTalks < ActiveRecord::Migration
  def change
    remove_column :talks, :location_id
  end
end
