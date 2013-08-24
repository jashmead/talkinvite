class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :file_type
      t.string :pathname
      t.string :attachable_type
      t.integer :attachable_id

      t.timestamps
    end
  end
end
