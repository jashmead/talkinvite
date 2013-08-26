class AddUniqueIndexToAttachments < ActiveRecord::Migration
  def change
    add_index :attachments, :pathname, :unique => true
  end
end
