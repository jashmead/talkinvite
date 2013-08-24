class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tagable_type
      t.integer :tabable_id
      t.string :tag_type
      t.string :tag

      t.timestamps
    end
  end
end
