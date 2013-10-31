class ServiceForeignKeys < ActiveRecord::Migration
  def up
    # keep = " on delete set null on update cascade "
    remove = " on delete cascade on update cascade "
    execute("alter table posts add constraint post2talk_fk foreign key (talk_id) references talks (id) #{remove}")
    execute("alter table posts add constraint post2person_fk foreign key (person_id) references people (id) #{remove}")
    execute("alter table services add constraint service2person_fk foreign key (person_id) references people (id) #{remove}")
  end
  def down
    execute("alter table posts drop constraint post2talk_fk")
    execute("alter table posts drop constraint post2person_fk")
    execute("alter table services drop constraint service2person_fk")
  end
end
