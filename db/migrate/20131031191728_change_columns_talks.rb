class ChangeColumnsTalks < ActiveRecord::Migration
  def change
    change_column :talks, :where_desc, :string
    change_column :talks, :who_desc, :string
  end
end
