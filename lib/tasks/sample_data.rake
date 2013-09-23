namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_people
    make_talks
    make_relationships
  end
end

def make_people
    Person.create!(
      name: "Example Person",
      email: "example@talkinvite.com",
      password: "foobar",
      password_confirmation: "foobar",
      admin: true,
      sub: true
    )
    99.times do |n|
      if n % 2 == 1 
        sub = true
      else
        sub = false
      end
      name  = Faker::Name.name
      email = "example-#{n+1}@talkinvite.com"
      password  = "password"
      Person.create!(
        name: name,
        email: email,
        password: password,
        password_confirmation: password,
        sub: sub
      )
    end
end

def make_talks
  people = Person.all(limit: 6)
  50.times do
    summary = Faker::Lorem.sentence(5)
    people.each { |person| person.talks.create!(summary: summary) }
  end
end

def make_relationships
  people = Person.all
  person = people.first
  followed_people = people[2..50]
  followers = people[3..40]
  followed_people.each { |followed| person.follow!(followed) }
  followers.each { |follower| follower.follow!(person) }
end
