# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    person
    venue_type "venues"

    sequence(:name)  { |n| "Venue #{n}" }
    sequence(:description) { |n| "Venue Description_#{n}"}

    longitude "90.0000000000000000000000"
    latitude "30.0000000000000000000000"
  end
end
