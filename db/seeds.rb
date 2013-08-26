# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## NOTE:  you can't name a field 'type', it confuses ruby or rails or something ...

anonymous1 = Person.create!( name: 'anonymous', email: 'anonymous@talkinvite.com', person_type: 'anon' )
talkinvite1 = Person.create!( name: 'talkinvite', email: 'talkinvite@talkinvite.com', person_type: 'site' )
jashmead1 = Person.create!( name: 'jashmead', email: 'jashmead@talkinvite.com', person_type: 'admin')
jrandomuser1 = Person.create!( name: 'jrandomuser', email: 'jrandomuser@talkinvite.com', person_type: 'reg' )
jrandomsubscriber1 = Person.create!( name: 'jrandomsubscriber', email: 'jrandomsubscriber@talkinvite.com', person_type: 'sub' )
