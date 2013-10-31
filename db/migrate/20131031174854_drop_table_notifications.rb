class DropTableNotifications < ActiveRecord::Migration
  def self.up
    drop_table :notifications
  end
end
