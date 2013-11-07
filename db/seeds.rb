# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# CAVEAT:  you can't name a field 'type', it confuses RoR (possibly because 'type' is used for polymorphism)
#
# NOTES:
#   -- don't force id's on these records; not in keeping with the spirit of rails or postgres

# TBD:  fix seed passwords to be real
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
# TBD:  need to clear out existing admins before doing the load? simplest is "delete from people" which will cascade down

anonymous1 = Person.create!( name: 'anonymous', email: 'anonymous@talkinvite.com', 
  password: 'foobar', password_confirmation: 'foobar' )

talkinvite1 = Person.create!( name: 'talkinvite', email: 'talkinvite@talkinvite.com', 
  password: 'foobar', password_confirmation: 'foobar', admin: true)

jashmead1 = Person.create!( name: 'jashmead', email: 'jashmead@talkinvite.com', 
  password: 'foobar', password_confirmation: 'foobar', admin: true, sub: true)

jrandomuser1 = Person.create!( name: 'jrandomuser', email: 'jrandomuser@talkinvite.com', 
  password: 'foobar', password_confirmation: 'foobar')

jrandomsubscriber1 = Person.create!( name: 'jrandomsubscriber', email: 'jrandomsubscriber@talkinvite.com', 
  password: 'foobar', password_confirmation: 'foobar', sub: true)
