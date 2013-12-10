class DropColumnsFromTalks < ActiveRecord::Migration
  def self.up
    remove_column :talks, :posted
    remove_column :talks, :privacy
  end
  def self.down
    add_column :talks, :posted, :datetime
    add_column :talks, :privacy, :string
  end
end
