class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.integer :talk_id
      t.integer :person_id
      t.string :rsvp_status
      t.string :partner_type

      t.timestamps
    end
  end
end
