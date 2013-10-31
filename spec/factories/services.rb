# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    person_id 1
    service_type "talkinvite"
    service_notes "MyText"
  end
end
