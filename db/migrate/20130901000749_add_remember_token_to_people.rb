class AddRememberTokenToPeople < ActiveRecord::Migration
  def change
    add_column :people, :remember_token, :string
    add_index :people, :remember_token
  end
end
