# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    person_id 1
    screen_name "MyString"
    content "MyString"
    location_id 1
  end
end
