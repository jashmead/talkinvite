class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.text :worthy_one, { :null => nil }
      t.text :service_supplied, { :null => nil }

      t.timestamps
    end
    add_index :credits, [ :worthy_one ], unique: true
  end
end
