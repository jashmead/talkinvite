class AddColumnToFaqs < ActiveRecord::Migration
  def change
    add_column :faqs, :faq_type, :string, { :default => 'faq' }
  end
end
