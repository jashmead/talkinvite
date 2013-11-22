class AddPersonToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :person_id, :integer, { null: nil }
  end
end
