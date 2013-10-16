class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.text :question, { :null => nil }
      t.text :answer, { :null => nil }

      t.timestamps
    end
    add_index :faqs, [ :question ], unique: true
  end
end
