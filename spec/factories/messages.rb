# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    from_person_id 1
    to_person_id 1
    talk_id 1
    message_type "MyString"
    content "MyText"
  end
end
