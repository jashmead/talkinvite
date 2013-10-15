class FixupSocials < ActiveRecord::Migration
  def self.up
    change_column :socials, :person_id, :integer, { :null => nil }
    change_column :socials,  :talk_id,  :integer,{ :null => nil }
    change_column :socials,  :social_type, :string, { :default => 'invite', :null => nil }

    remove = " on delete cascade on update cascade "
    add_index :socials, [:person_id, :talk_id], unique: true

    execute("alter table socials add constraint social2to_talk_fk foreign key (talk_id) references talks (id) #{remove}")
    execute("alter table socials add constraint social2to_person_fk foreign key (person_id) references people (id) #{remove}")
  end

  def self.down
    drop_table :socials
  end
end
