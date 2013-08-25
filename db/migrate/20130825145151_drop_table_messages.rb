class DropTableMessages < ActiveRecord::Migration
  def self.up
    drop_table :messages
  end
end
