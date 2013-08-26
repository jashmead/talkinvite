# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "My Name"
    email "myemail@talkinvite.com"
    about_me "About Me"
    screen_name "MyScreenName"
    settings "MySettings"
  end
end
