# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#   
#   note:  better to use 'create!' to avoid silent fails

# CAVEATS:  
#   -- you can't name a field 'type', it confuses RoR (possibly because 'type' is used for polymorphism)
#   -- you also can't name a table 'files'
#
# NOTES:
#   -- don't force id's on these records; not in keeping with the spirit of rails or postgres

# TBD:  fix seed passwords to be real -- done
# TBD:  allow load from a seeds.sql
#   per http://stackoverflow.com/questions/8342642/how-can-i-import-a-sql-file-into-a-rails-database
#     ActiveRecord::Base.connection.execute(IO.read("path/to/file"))
#   per http://stackoverflow.com/questions/3724487/rails-root-directory-path
#     to build a path up:
#     -- Rails.root.to_s + path elements 
#     -- Rails.root.join('foo','bar') -- even more correct
#   -- could also run a ruby script which runs a psql which loads a csv or a set of them
#     -- ActiveRecord is cleaner:  eliminated both ruby interpreter & psql
# TBD:  figure out how to save the correct data to that 'sql' file in the first place:
#   -- save out the credits, faqs, & helps
#   -- save out the admin users & anonymous
#   -- perhaps save out some key test users as well
#   -- setup the save script as a rake task, i.e. db:make_seeds
#   -- set up seed admins as one file, credits, faqs, & helps as another
#   -- no RI issues with these tables!
#   -- note:  we can do a rake db:structure:load from structure.sql!
# TBD:  how to run a trace of some kind inside seeds.rb?  logger is not available, apparently

  # find_or_create_by: http://guides.rubyonrails.org/active_record_querying.html#find-or-create-by

  # TBD:  we aren't seeing these records getting saved; why?
  #   -- tried using find_or_create_by, then save; that also did nothing!

# real users are getting real passwords
Person.force!( 'anonymous', 'anonymous@talkinvite.com', 'W}8#u{T;w 0["uq' )
Person.force!( 'talkinvite', 'talkinvite@talkinvite.com', 'xorx*18En;53^X_', { admin: true, sub: true })
Person.force!( 'jashmead', 'jashmead@talkinvite.com', 'Dr@g0n13', { admin: true, sub: true } )
Person.force!( 'jrandomuser1', 'jrandomuser@talkinvite.com', 'foobar' )
Person.force!( 'jrandomsub1', 'jrandomsub@talkinvite.com', '_?,:y65(q!&R2fU', { sub: true } )
