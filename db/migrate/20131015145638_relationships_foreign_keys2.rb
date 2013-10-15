class RelationshipsForeignKeys2 < ActiveRecord::Migration
  def up
    # keep = " on delete set null on update cascade "
    remove = " on delete cascade on update cascade "
    execute("alter table relationships add constraint relationship2to_person_fk foreign key (follower_id) references people (id) #{remove}")
    execute("alter table relationships add constraint relationship2from_person_fk foreign key (followed_id) references people (id) #{remove}")
  end
  def down
    execute("alter table relationships drop constraint relationship2to_person_fk")
    execute("alter table relationships drop constraint relationship2from_person_fk")
  end
end
