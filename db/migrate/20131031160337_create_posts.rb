class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :person_id, { null: nil }
      t.integer :talk_id, { null: nil }
      t.string :service_type, { default: 'talkinvite', null: nil }
      t.text :service_notes
      t.string :post_type, { default: 'post', null: nil }
      t.text :post_message

      t.timestamps
    end
  end
end
