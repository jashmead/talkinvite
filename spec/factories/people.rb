# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    # JRU = J. Random User
    # name "jru"
    # email { "#{name}@talkinvite.com" }

    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@talkinvite.com"}

    password "Chattynuga"
    password_confirmation "Chattynuga"

    # FactoryGirl recommends that the base instance have least possible # of fields
    # about_me, screen_name, settings are not mandatory, so are left out

    # sequence(:about_me) { |n| "about person ##{n}" }
    # sequence(:screen_name) { |n| "person_#{n}" }
    # sequence(:settings) { |n| "settings for person ##{n}" }

    factory :admin do
      admin true
    end

    factory :sub do
      sub true
    end

  end
end
