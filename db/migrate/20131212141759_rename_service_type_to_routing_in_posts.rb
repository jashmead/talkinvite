class RenameServiceTypeToRoutingInPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :service_type, :routing
    change_column :posts, :routing, :string, { default: 'talkinvite' }
  end
end
