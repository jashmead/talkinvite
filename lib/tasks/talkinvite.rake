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


  desc "Clear out the people table in development"

  ## task :clear_people do
    ## system("echo delete from people | psql -U talkinvite -d talkinvite_development")
  ## end

  ## the "=> :environment" wraps us in a warm, fuzzy ActiveRecord environment
  task :clear_people => :environment do
    Person.delete_all
  end

end
