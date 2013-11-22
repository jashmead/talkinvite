class AddForeignKeyToMaps < ActiveRecord::Migration
  def up
    # add_reference :maps, :talk, index: true
    execute("alter table maps add constraint map2talk_fk foreign key (talk_id) references talks (id) on delete cascade on update cascade" )
  end
  def drop
    execute("alter table maps drop constraint map2talk_fk")
    # remove_reference :maps, :talk
  end
end
