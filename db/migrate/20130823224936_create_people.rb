class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.text :about_me
      t.string :twitter_handle
      t.string :settings

      t.timestamps
    end
  end
end
