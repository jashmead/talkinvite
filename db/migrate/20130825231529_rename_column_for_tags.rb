class RenameColumnForTags < ActiveRecord::Migration
  def change
    rename_column :tags, :tabable_id, :tagable_id
  end
end
