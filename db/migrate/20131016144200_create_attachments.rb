class CreateAttachments < ActiveRecord::Migration
  def change
    execute("drop table if exists attachments")
    create_table :attachments do |t|
      t.string :name, { :null => nil }
      t.text :description
      t.string :attachment_type, { :null => nil, :default => 'image' }
      t.string :attachable_type, { :null => nil }
      t.integer :attachable_id, { :null => nil }
      t.string :file_path

      t.timestamps
    end
    add_index :attachments, [ :attachable_id, :attachable_type ], unique: true
    add_index :attachments, [ :file_path ], unique: true
  end
end
