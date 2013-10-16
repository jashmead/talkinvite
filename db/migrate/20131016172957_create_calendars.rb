class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :name
      t.text :description
      t.text :chronometry, { :null => nil, :default => "{}" }
      t.text :settings, { :null => nil, :default => "{}" }
      t.text :history, { :null => nil, :default => "{}" }

      t.timestamps
    end
  end
end
