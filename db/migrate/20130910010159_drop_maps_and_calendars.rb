class DropMapsAndCalendars < ActiveRecord::Migration
  def up
    drop_table :maps
    drop_table :calendars
  end
end
