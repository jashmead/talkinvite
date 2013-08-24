# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    name "MyString"
    description "MyString"
    longitude 1.5
    latitude 1.5
    address "MyString"
  end
end
