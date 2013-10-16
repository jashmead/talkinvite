# references doesn't work, just creates the one field, not both

class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag_type, { :null => nil }
      t.string :tagable_type, index: true
      t.integer :tagable_id

      t.timestamps
    end
    add_index :tags, [:tagable_id, :tagable_type, :tag_type], unique: true
    add_index :tags, [:tag_type, :tagable_type] # for reverse lookups
  end
end
