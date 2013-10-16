class DropTalkIdFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :talk_id, :integer
  end
end
