class RemoveFiveTables < ActiveRecord::Migration
  def change
    drop_table :tags
    drop_table :attachments
    drop_table :tweets
    drop_table :locations
    drop_table :posts
  end
end
