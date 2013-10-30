# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    person
    venue_type "venues"

    name "MyString"
    description "MyText"

    longitude "90.0000000000000000000000"
    latitude "30.0000000000000000000000"
  end
end
