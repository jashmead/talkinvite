class AddHelpTypeToHelps < ActiveRecord::Migration
  def change
    add_column :helps, :title, :string
    add_column :helps, :help_type, :string, { default: 'page', null: nil }
  end
end
