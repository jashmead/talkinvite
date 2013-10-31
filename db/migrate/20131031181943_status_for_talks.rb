class StatusForTalks < ActiveRecord::Migration
  def change
    remove_column :talks, :active_flag
    add_column :talks, :talk_status, :string, { default: 'new', null: nil }
  end
end
