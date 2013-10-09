class CreateTable < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :relationships
      t.integer :follower_id
      t.integer :followed_id
    end
  end
end
