class DropColumnServiceNotesFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :service_notes
  end
end
