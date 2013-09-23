# rakefile for talkinvite

# default didn't get picked up by plain 'rake'
# to run:  rake talkinvite:test1
task :default => 'talkinvite:test1'

namespace :talkinvite do
  desc "test rakefile for talkinvite"

  task :test1 do
    puts "Testing talkinvite rakefile"
  end
end

# planning to add in better rdoc handling here, once we work out the rakefile search path & so on
# to run:  rake doc:test2
namespace :doc do
  desc "test rakefile for additions to 'doc' namespace"
  
  task :test2 do
    puts "Testing doc"
  end
end

namespace :db do

  desc "Prints the migrated versions"

  task :schema_migrations => :environment do
    puts ActiveRecord::Base.connection.select_values (
      'select version from schema_migrations order by version desc'
    )
  end


  desc "Clear out the tables in development; default reset task is confused by foreign keys"

  ## the "=> :environment" wraps us in a warm, fuzzy ActiveRecord environment
  ## may need to rebuild the foreign keys here; see how it plays out...
  ## should fix the corresponding sequences as well, is there an ActiveRecord command for this?
  task :reset => :environment do
    Relationship.delete_all
    Talk.delete_all
    Person.delete_all
  end

end
