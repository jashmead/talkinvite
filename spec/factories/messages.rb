# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    message_type "email"
    sender
    receiver
    message_text "MyText"
  end
end
