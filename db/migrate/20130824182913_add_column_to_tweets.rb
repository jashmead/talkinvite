class AddColumnToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :post_id, :integer
  end
end
