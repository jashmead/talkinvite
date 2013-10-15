class MemberDefaults < ActiveRecord::Migration

  def self.up
    change_table :members do |t|
      t.change :member_type, :string, { :default => "", :null => false }
      t.change :rsvp_status, :string, { :default => 'accepted', :null => false }  # can also be 'declined', 'maybe'
    end

    remove = " on delete cascade on update cascade "

    add_index :members, [:person_id, :talk_id], unique: true

    execute("alter table members add constraint member2to_talk_fk foreign key (talk_id) references talks (id) #{remove}")
    execute("alter table members add constraint member2to_person_fk foreign key (person_id) references people (id) #{remove}")
  end

  def self.down
    change_table :members do |t|
      t.change :member_type, :string
      t.change :rsvp_status, :string
    end

    execute("alter table members drop constraint member2to_talk_fk")
    execute("alter table members drop constraint member2to_person_fk")
  end

end
