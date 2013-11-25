class AddPreviousMessageIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :previous_message_id, :integer
    add_index :messages, :previous_message_id
  end
end
