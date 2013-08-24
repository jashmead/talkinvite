class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|

      t.column :from_person_id, :integer, :null => :false
      t.column :to_person_id, :integer, :null => :false

      t.references(:talk)

      t.string :message_type
      t.text :content

      t.timestamps
    end
  end
  def self.down
    drop_table :messages
  end
end
