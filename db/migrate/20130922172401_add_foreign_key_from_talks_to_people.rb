class AddForeignKeyFromTalksToPeople < ActiveRecord::Migration
  def up
    # keep = " on delete set null on update cascade "
    remove = " on delete cascade on update cascade "
    execute("alter table talks add constraint talk2to_person_fk foreign key (person_id) references people (id) #{remove}")
  end
  def down
    execute("alter table talks drop constraint talk2to_person_fk foreign key")
  end
end
