namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Person.create!(name: "Example Person",
                 email: "example@talkinvite.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      if n % 2 == 1 
        person_type = 'reg'
      else
        person_type = 'sub'
      end
      name  = Faker::Name.name
      email = "example-#{n+1}@talkinvite.com"
      password  = "password"
      Person.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   person_type: person_type)
    end
  end
end
