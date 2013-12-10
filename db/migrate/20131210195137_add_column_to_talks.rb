class AddColumnToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :talk_who, :text
  end
end
