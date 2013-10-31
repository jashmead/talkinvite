class EndRelationships < ActiveRecord::Migration
  def self.up
    execute("drop table relationships")
  end
end
