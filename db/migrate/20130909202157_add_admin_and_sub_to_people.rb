class AddAdminAndSubToPeople < ActiveRecord::Migration
  def change
    add_column :people, :admin, :boolean, default: false
    add_column :people, :sub, :boolean, default: false
  end
end
