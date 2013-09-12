class RemoveColumnsFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :screen_name
    remove_column :people, :settings
    remove_column :people, :about_me
  end
  def down
    add_column :people, :about_me, :text
    add_column :people, :screen_name, :string
    add_column :people, :settings, :text
  end
end
