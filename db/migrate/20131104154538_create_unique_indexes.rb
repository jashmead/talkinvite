class CreateUniqueIndexes < ActiveRecord::Migration
  def change
    add_index :credits, :name, :unique => true
    add_index :helps, :name, :unique => true
  end
end
