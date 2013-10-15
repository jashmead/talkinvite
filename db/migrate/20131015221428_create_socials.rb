class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
      t.integer :person_id
      t.integer :talk_id
      t.string :social_type
      t.text :social_text

      t.timestamps
    end
  end
end
