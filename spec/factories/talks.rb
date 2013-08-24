# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    summary "MyString"
    description "MyText"
    location_id 1
  end
end
