class CreateRelationships3 < ActiveRecord::Migration
  def change
    ## replace follower_id with from_person_id
    ## replace followed_id with to_person_id
    ## add in rel_type, defaulting to 'FOLLOW', limit 32
    execute("drop table if exists relationships")   # unwedge rake db:migrate
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    ## replace these with foreign keys
    ## and a unique index on from_person_id, to_person_id, and rel_type
    # add_index :relationships, :follower_id
    # add_index :relationships, :followed_id
    # add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
