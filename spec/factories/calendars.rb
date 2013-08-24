# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calendar do
    person_id 1
    name "MyString"
    description "MyText"
    time_point "2013-08-24 16:14:12"
    source "MyString"
    settings "MyText"
  end
end
