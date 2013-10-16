class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :message_type, { :default => 'email', :null => nil }
      t.integer :sender_id, { :null => nil }
      t.integer :receiver_id, { :null => nil }
      t.integer :talk_id  # nulls allowed for talk#!
      t.text :message_text, { :null => nil }

      t.timestamps
    end

    remove = "on delete cascade on update cascade"
    execute("alter table messages add constraint message2sender_fk foreign key (sender_id) references people (id) #{remove}")
    execute("alter table messages add constraint message2receiver_fk foreign key (receiver_id) references people (id) #{remove}")
    execute("alter table messages add constraint message2talk_fk foreign key (talk_id) references talks (id) on delete set null on update set null")
  end
  def self.down
    drop_table :messages
  end
end
