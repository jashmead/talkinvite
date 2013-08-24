# rakefile for talkinvite

# default didn't get picked up by plain 'rake'
task :default => 'talkinvite:test1'

namespace :talkinvite do

  desc "test rakefile for talkinvite"
  task :test1 do
    puts "Testing talkinvite rakefile"
  end

end

# planning to add in better rdoc handling here, once we work out the rakefile search path & so on
namespace :doc do
  
  desc "test rakefile for additions to 'doc' namespace"
  task :test2 do
    puts "Testing doc"
  end

end
