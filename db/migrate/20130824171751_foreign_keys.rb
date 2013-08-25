class ForeignKeys < ActiveRecord::Migration
  def up
    keep = " on delete set null on update cascade "
    remove = " on delete cascade on update cascade "

    execute("alter table attachments add constraint attachment2person_fk foreign key (person_id) references people (id) #{keep}")
    execute("alter table calendars add constraint calendar2person_fk foreign key (person_id) references people (id) #{remove}")
    execute("alter table maps add constraint map2person_fk foreign key (person_id) references people (id) #{remove}")

    execute("alter table messages add constraint message2to_person_fk foreign key (to_person_id) references people (id) #{remove}")
    execute("alter table messages add constraint message2from_person_fk foreign key (from_person_id) references people (id) #{remove}")
    execute("alter table messages add constraint message2talk_fk foreign key (talk_id) references talks (id) #{remove}")

    execute("alter table posts add constraint post2talk_fk foreign key (talk_id) references talks (id) #{remove}")

    execute("alter table tweets add constraint tweet2person_fk foreign key (person_id) references people (id) #{remove}")
    execute("alter table tweets add constraint tweet2location_fk foreign key (location_id) references locations (id) #{keep}")
  end

  def down
    execute("alter table attachments drop constraint attachment2person_fk")
    execute("alter table calendars drop constraint calendar2person_fk")
    execute("alter table maps drop constraint map2person_fk")

    execute("alter table messages drop constraint message2to_person_fk")
    execute("alter table messages drop constraint message2from_person_fk")
    execute("alter table messages drop constraint message2talk_fk")

    execute("alter table posts drop constraint post2talk_fk")

    execute("alter table tweets drop constraint tweet2person_fk")
    execute("alter table tweets drop constraint tweet2location_fk")
  end
end
