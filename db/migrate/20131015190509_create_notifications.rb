class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :person_id, { :null => nil }
      t.integer :talk_id, { :null => nil }
      t.string :note_type, { :default => 'announce', :null => nil }
      t.text :note_text

      t.timestamps
    end

    remove = " on delete cascade on update cascade "

    add_index :notifications, [:person_id, :talk_id], unique: true

    execute("alter table notifications add constraint notification2to_talk_fk foreign key (talk_id) references talks (id) #{remove}")
    execute("alter table notifications add constraint notification2to_person_fk foreign key (person_id) references people (id) #{remove}")
  end

  def self.down
    drop_table :notifications
  end
end
