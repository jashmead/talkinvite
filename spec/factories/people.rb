# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "JRU"
    email "jru@example.com"
    password "foobar"
    password_confirmation "foobar"
    # about_me, screen_name, settings, & person_type are talkinvite addons
    about_me "about jru"
    screen_name "jru"
    settings ""
    person_type "reg"
  end
end
