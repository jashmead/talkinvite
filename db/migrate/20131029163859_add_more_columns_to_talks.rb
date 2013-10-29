class AddMoreColumnsToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :where_desc, :string, { default: 'here' }
    add_column :talks, :when_desc, :string, { default: 'now' }
  end
end
