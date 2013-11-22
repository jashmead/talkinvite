class AddTalkColumnToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :talk_id, :integer
  end
end
