class Fixup < ActiveRecord::Migration
  # fixup confused state that automated migrations have gotten us into
  def up
    execute("drop table tables")
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    ## replace these with foreign keys
    ## and a unique index on from_person_id, to_person_id, and rel_type
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
