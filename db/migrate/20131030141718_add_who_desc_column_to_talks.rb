class AddWhoDescColumnToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :who_desc, :string
  end
end
