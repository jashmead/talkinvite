class AlterColumnForLocation < ActiveRecord::Migration
  def change
    change_table :locations do |t|
      t.change(:description, :text)
    end
  end
end
