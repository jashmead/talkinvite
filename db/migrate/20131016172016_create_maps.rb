class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :name
      t.string :description
      t.text :geometry, { :null => nil, :default => "{}" }
      t.text :settings, { :null => nil, :default => "{}" }
      t.text :history, { :null => nil, :default => "{}" }

      t.timestamps
    end
  end
end
