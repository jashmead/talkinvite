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
#   -- using 'seeded' data is confusing some of the tests from the tutorial, which want to start with a blank slate
#     -- with that said, operational correctness mandates the seeds!
#   -- should fix the passwords to be real

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
