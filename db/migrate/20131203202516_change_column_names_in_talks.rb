class ChangeColumnNamesInTalks < ActiveRecord::Migration
  def change
    rename_column :talks, :who_desc, :privacy
    rename_column :talks, :where_desc, :address
  end
end
