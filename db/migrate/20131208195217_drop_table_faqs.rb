class DropTableFaqs < ActiveRecord::Migration
  def self.up
    drop_table :faqs
  end
  def self.down
    create_table "faqs", force: true do |t|
      t.text     "question"
      t.text     "answer"
      t.timestamps
    end
  end
end
