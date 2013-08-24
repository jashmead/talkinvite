class RenameColumns < ActiveRecord::Migration
  def change
    rename_column :posts, :user_id, :person_id
    rename_column :tweets, :user_id, :person_id
    rename_column :attachments, :user_id, :person_id
    rename_column :maps, :user_id, :person_id
    rename_column :calendars, :user_id, :person_id
  end
end
