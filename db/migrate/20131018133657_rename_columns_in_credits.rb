class RenameColumnsInCredits < ActiveRecord::Migration
  def change
    rename_column :credits, :worthy_one, :name
    rename_column :credits, :service_supplied, :description
  end
end
