class AlterDefaultForTalkStatus < ActiveRecord::Migration
  def change
    change_column :talks, :talk_status, :string, { default: 'draft', null: nil }
  end
end
