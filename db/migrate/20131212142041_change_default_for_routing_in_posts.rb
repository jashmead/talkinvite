class ChangeDefaultForRoutingInPosts < ActiveRecord::Migration
  def change
    change_column :posts, :routing, :string, { default: 'message', null: nil }
  end
end
