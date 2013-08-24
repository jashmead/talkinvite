class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.datetime :time_point
      t.string :source
      t.text :settings

      t.timestamps
    end
  end
end
