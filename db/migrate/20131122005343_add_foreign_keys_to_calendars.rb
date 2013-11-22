class AddForeignKeysToCalendars < ActiveRecord::Migration
  def up
    # add_reference :calendars, :talk, index: true
    execute("alter table calendars add constraint calendar2talk_fk foreign key (talk_id) references talks (id) on delete cascade on update cascade" )
  end
  def drop
    execute("alter table calendars drop constraint calendar2talk_fk")
    # remove_reference :calendars, :talk
  end
end
