class ForeignKeys < ActiveRecord::Migration
  def up
    execute("alter table attachments add constraint attachment2person_fk foreign key (person_id) references people (id)")
    execute("alter table cards add constraint card2attachment_fk foreign key (attachment_id) references cards (id)")
    execute("alter table spreads add constraint spread2person_fk foreign key (person_id) references people (id)")
    execute("alter table spreads add constraint spread2attachment_fk foreign key (attachment_id) references attachments (id)")
    execute("alter table positions add constraint position2spread_fk foreign key (spread_id) references spreads (id)")
    execute("alter table readings add constraint reading2person_fk foreign key (person_id) references people (id)")
    execute("alter table readings add constraint reading2attachment_fk foreign key (attachment_id) references attachments (id)")
    execute("alter table readings add constraint reading2spread_fk foreign key (spread_id) references spreads (id)")
    execute("alter table plays add constraint play2card_fk foreign key (card_id) references cards (id)")
    execute("alter table plays add constraint play2reading_fk foreign key (reading_id) references readings (id)")
  end
  def down
    execute("alter table attachments drop constraint attachment2person_fk")
    execute("alter table cards drop constraint card2attachment_fk")
    execute("alter table spreads drop constraint spread2person_fk")
    execute("alter table spreads drop constraint spread2attachment_fk")
    execute("alter table positions drop constraint position2spread_fk")
    execute("alter table readings drop constraint reading2person_fk")
    execute("alter table readings drop constraint reading2attachment_fk")
    execute("alter table readings drop constraint reading2spread_fk")
    execute("alter table plays drop constraint play2card_fk")
    execute("alter table plays drop constraint play2reading_fk")
  end
end
