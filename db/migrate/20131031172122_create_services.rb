class CreateServices < ActiveRecord::Migration
  def change
    execute("drop table if exists services")
    create_table :services do |t|
      t.integer :person_id, { null: nil }
      t.string :service_type, { default: 'talkinvite', null: nil }
      t.text :service_notes

      t.timestamps
    end
  end
end
