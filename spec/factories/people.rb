# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "John Ashmead"
    email "john.ashmead@timeandquantummechanics.com"
    about_me "Developer of TalkInvite"
    screen_name "mapsndata"
    settings ""
    person_type "admin"
    password "foobar"
    password_confirmation "foobar"
  end
end
