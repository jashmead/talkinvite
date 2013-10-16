class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :name, { :null => nil }
      t.text :description
      t.boolean :internal_flag, { :null => nil, :default => true }
      t.text :content, { :null => nil }
      t.text :source, { :null => nil }
      t.text :strategy
      t.text :stats

      t.timestamps
    end
  end
end
