class AddColumnsToTalks < ActiveRecord::Migration
  def change
    # nil allowed for all but active flag
    add_column :talks, :start_dt, :datetime
    add_column :talks, :end_dt, :datetime
    add_column :talks, :posted_dt, :datetime
    add_column :talks, :active_flag, :boolean, { null: nil, default: true }
  end
end
