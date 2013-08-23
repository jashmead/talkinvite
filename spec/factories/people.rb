# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "MyString"
    email "MyString"
    about_me "MyText"
    twitter_handle "MyString"
    settings "MyString"
  end
end
