class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :venue_type, { :default => 'venue', :null => nil }
      t.integer :person_id, { :null => nil }
      t.string :name, { :null => nil }
      t.text :description
      t.decimal :longitude
      t.decimal :latitude

      t.timestamps
    end

    remove = " on delete cascade on update cascade "
    execute("alter table venues add constraint venue2person_fk foreign key (person_id) references people (id) #{remove}")
  end

  def self.down
    drop_table :venues
  end
end
