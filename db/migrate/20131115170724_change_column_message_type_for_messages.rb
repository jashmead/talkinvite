class ChangeColumnMessageTypeForMessages < ActiveRecord::Migration
  def change
    change_column :messages, :message_type, :string, { default: 'talkinvite', null: nil }
  end
end
