class AddColumnPersonToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :person_id, :integer
    add_index :talks, [:person_id, :created_at]
  end
end
