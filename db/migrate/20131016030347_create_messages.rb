class CreateMessages < ActiveRecord::Migration
  def self.up
    execute("drop table if exists messages")
    create_table :messages do |t|
      t.integer :sender_id, { :null => nil }
      t.integer :receiver_id, { :null => nil }
      t.string :message_type, { :default => 'email', :null => nil }
      t.text :message_text, { :null => nil }

      t.timestamps
    end

    remove = "on delete cascade on update cascade"
    execute("alter table messages add constraint message2sender_fk foreign key (sender_id) references people (id) #{remove}")
    execute("alter table messages add constraint message2receiver_fk foreign key (receiver_id) references people (id) #{remove}")
  end

  def self.down
    drop_table :messages
  end
end
