class AddServiceTypeToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :service_type, :string, { default: 'talkinvite', null: nil }
  end
end
