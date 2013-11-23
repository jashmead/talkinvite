class AddPostedToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :posted, :datetime
  end
end
