# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "JRU"
    email "jru@example.com"
    about_me "about jru"
    screen_name "jru"
    settings ""
    person_type "reg"
    password "foobar"
    password_confirmation "foobar"
  end
end
