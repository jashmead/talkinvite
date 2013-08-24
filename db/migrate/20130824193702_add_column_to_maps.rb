class AddColumnToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :source, :string
  end
end
