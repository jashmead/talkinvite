# allowed options for add_column are limit, null, default, scale, & precision
#  see http://apidock.com/rails/ActiveRecord/ConnectionAdapters/SchemaStatements/add_column#168-See-TableDefinition-column-for-options
class CreateRelationships < ActiveRecord::Migration
  def change
    execute("drop table if exists relationships")   # unwedge rake db:migrate
    create_table :relationships do |t|
      t.integer :from_id, :null => false
      t.integer :to_id, :null => false
      t.string :rel_type, :default => 'FOLLOW', :limit => 32, :null => false    # deliberately left free form and short

      t.timestamps
    end
    # Index name 'index_relationships_on_from_person_id_and_to_person_id_and_rel_type' on table 'relationships' is too long; the limit is 63 characters, so have to shorten!
    add_index :relationships, [ :from_id, :to_id, :rel_type ], :unique => true
    add_index :relationships, :to_id
  end
end
