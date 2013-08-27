class SetDefaultValues < ActiveRecord::Migration

  def change
    change_table :attachments do |t|
      t.change :attachable_type, :string, { :default => "talks", :null => false }
    end
    change_table :people do |t|
      t.change :person_type, :string, { :default => "sub", :null => false }
    end
    change_table :posts do |t|
      t.change :post_type, :string, { :default => "comment", :null => false }
    end
    change_table :tags do |t|
      t.change :tagable_type, :string, { :default => "talks", :null => false }
    end
  end

  def self.down
    # You can't currently remove default values in Rails
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end

end
