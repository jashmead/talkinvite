class RenameTwitterColumnForPeople < ActiveRecord::Migration
  def change
    rename_column :people, :twitter_handle, :screen_name
  end
end
