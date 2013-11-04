class ChangePosts < ActiveRecord::Migration
  def change
    change_column :posts, :person_id, :integer, { null: nil }
    change_column :posts, :talk_id, :integer, { null: nil }
    change_column :posts, :service_type, :string, { null: nil, default: 'talkinvite' }
  end
end
