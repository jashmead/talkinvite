class PartnerTypeDefault < ActiveRecord::Migration
  def self.up
    change_table :partners do |t|
      t.change :partner_type, :string, { :default => "partner", :null => false }
    end
  end
  def self.down
    change_table :partners do |t|
      t.change :partner_type, :string
    end
  end
end
