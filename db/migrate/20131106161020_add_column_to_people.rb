class AddColumnToPeople < ActiveRecord::Migration
  def change
    add_column :people, :description, :text
  end
end
