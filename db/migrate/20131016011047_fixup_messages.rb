class FixupMessages < ActiveRecord::Migration
  def self.up
    ## change_column :messages, :talk_id, :integer, { :null => nil }
    ## execute("alter table messages drop constraint message2talk_fk")
    ## execute("alter table messages add constraint message2talk_fk foreign key (talk_id) references talks (id) on delete cascade on update cascade")
  end
end
