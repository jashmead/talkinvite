class MemberTypeDefault < ActiveRecord::Migration
  def self.up
    change_table :members do |t|
      t.change :member_type, :string, { :default => "member", :null => false }
    end
  end
  def self.down
    change_table :members do |t|
      t.change :member_type, :string
    end
  end
end
