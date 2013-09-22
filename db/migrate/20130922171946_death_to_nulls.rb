class DeathToNulls < ActiveRecord::Migration
  def up
    change_column :people, :admin, :boolean, { :null => false }
    change_column :people, :sub, :boolean, { :null => false }
    change_column :talks, :person_id, :integer, { :null => false }
  end
  def down
    change_column :people, :admin, :boolean, { :null => true }
    change_column :people, :sub, :boolean, { :null => true }
    change_column :talks, :person_id, :integer, { :null => true }
  end
end
