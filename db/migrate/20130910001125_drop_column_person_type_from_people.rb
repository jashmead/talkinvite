class DropColumnPersonTypeFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :person_type
  end
  def down
    add_column :people, :person_type, :string, :default => 'reg'
  end
end
