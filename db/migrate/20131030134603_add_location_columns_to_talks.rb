class AddLocationColumnsToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :longitude, :numeric
    add_column :talks, :latitude, :numeric
  end
end
