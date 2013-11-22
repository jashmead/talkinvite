class CreateTableCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.references :talk, { null: nil }
      t.string :name, { null: nil }
      t.text :description
      t.string :scale, { null: nil, default: 'day' }

      t.timestamps
    end
  end
end
