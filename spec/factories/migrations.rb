# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :migration do
    notification "MyString"
    person_id 1
    talk_id 1
    notification_type "MyString"
    notification_text "MyText"
  end
end
