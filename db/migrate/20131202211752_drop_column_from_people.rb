class DropColumnFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :sub
  end
end
