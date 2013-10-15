class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :talk_id
      t.integer :person_id
      t.string :rsvp_status
      t.string :member_type

      t.timestamps
    end
  end
end
