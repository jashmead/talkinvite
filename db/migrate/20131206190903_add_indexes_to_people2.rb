class AddIndexesToPeople2 < ActiveRecord::Migration
  def change
    add_index :people, :name, :unique => true
  end
end
