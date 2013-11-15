class AddTalkIdToMessages < ActiveRecord::Migration
  def up
    add_reference :messages, :talk, index: true
    # execute("alter table messages add constraint message2talk_fk foreign key (talk_id) references talks (id) on delete set null on update cascade" )
  end
  def drop
    # execute("alter table messages drop constraint message2talk_fk")
    remove_reference :messages, :talk
  end
end
