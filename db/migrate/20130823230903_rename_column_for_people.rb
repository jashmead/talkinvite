class RenameColumnForPeople < ActiveRecord::Migration
  def change
    rename_column :people, :type, :person_type
  end
end
