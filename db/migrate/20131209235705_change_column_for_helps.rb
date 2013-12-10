class ChangeColumnForHelps < ActiveRecord::Migration
  def change
    change_column :helps, :description, :text
  end
end
