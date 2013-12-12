class AddColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_title, :string, { default: 'Hi There! Want to talk?', null: nil }
  end
end
