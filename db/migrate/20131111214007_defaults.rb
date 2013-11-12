class Defaults < ActiveRecord::Migration
  def change
    change_column :talks, :talk_status, :string, { default: 'start', null: nil }
    change_column :posts, :post_type, :string, { default: 'announce', null: nil }
  end
end
