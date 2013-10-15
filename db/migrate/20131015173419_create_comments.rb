class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.integer :person_id
      t.integer :talk_id
      t.text :comment_text

      t.timestamps
    end
    remove = " on delete cascade on update cascade "

    add_index :comments, [:person_id, :talk_id], unique: true

    execute("alter table comments add constraint comment2to_talk_fk foreign key (talk_id) references talks (id) #{remove}")
    execute("alter table comments add constraint comment2to_person_fk foreign key (person_id) references people (id) #{remove}")
  end

  def down
    drop_table :comments
  end

end
