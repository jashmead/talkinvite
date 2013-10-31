class KillDefaults < ActiveRecord::Migration
  def change
    remove_column :talks, :where_desc
    remove_column :talks, :when_desc
    add_column :talks, :where_desc, :string
    add_column :talks, :when_desc, :string
  end
end
