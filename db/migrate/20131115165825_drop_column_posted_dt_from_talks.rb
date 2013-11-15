class DropColumnPostedDtFromTalks < ActiveRecord::Migration
  def up
    remove_column :talks, :posted_dt
  end
  def down
    add_column :talks, :posted_dt, :datetime
  end
end
