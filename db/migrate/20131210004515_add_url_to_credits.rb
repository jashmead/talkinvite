class AddUrlToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :url, :string
  end
end
