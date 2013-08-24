# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :map do
    user_id 1
    name "MyString"
    description "MyText"
    location_id 1
    settings "MyText"
  end
end
