class AddForeignKeysToMapsAndCalendars < ActiveRecord::Migration
  def up
    execute("alter table calendars add constraint calendar2person_fk foreign key (person_id) references people (id) on delete cascade on update cascade" )
    execute("alter table maps add constraint map2person_fk foreign key (person_id) references people (id) on delete cascade on update cascade" )
  end
  def drop
    execute("alter table calendars drop constraint calendar2person_fk")
    execute("alter table maps drop constraint map2person_fk")
  end
end
