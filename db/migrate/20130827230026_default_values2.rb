class DefaultValues2 < ActiveRecord::Migration
  def change
    change_table :people do |t|
      t.change :person_type, :string, { :default => "reg", :null => false }
    end
  end
end
