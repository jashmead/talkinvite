class NotNull < ActiveRecord::Migration
  def change
    change_table :people do |t|
      t.change :name, :string, { :null => false }
      t.change :email, :string, { :null => false }
    end
  end
end
