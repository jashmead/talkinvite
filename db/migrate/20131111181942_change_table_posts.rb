class ChangeTablePosts < ActiveRecord::Migration
  def change
    change_column :posts, :post_type, :string, { null: nil, default: 'start' }
  end
end
