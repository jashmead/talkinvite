namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
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
end
