class AddDatetimeColumnsToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :talk_date, :date
    add_column :talks, :talk_time, :time
    add_column :talks, :talk_duration, :integer
    remove_column :talks, :when_desc, :string
    remove_column :talks, :start_dt, :datetime
    remove_column :talks, :end_dt, :datetime
  end
end
