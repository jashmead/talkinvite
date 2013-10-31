class ChangeDefaultForPostType < ActiveRecord::Migration
  def change
    change_column :posts, :post_type,:string,  { default: 'announce', null: nil}
  end
end
