class DropColumnFromFaqs < ActiveRecord::Migration
  def change
    remove_column :faqs, :faq_type
  end
end
