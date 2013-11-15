class AddForeignKeyToMessages < ActiveRecord::Migration
  def up
    execute("alter table messages add constraint message2talk_fk foreign key (talk_id) references talks (id) on delete set null on update cascade" )
  end
  def drop
    execute("alter table messages drop constraint message2talk_fk")
  end
end
