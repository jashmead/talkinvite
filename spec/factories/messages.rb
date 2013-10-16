# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    sender
    receiver
    message_type "email"
    sequence(:message_text) { |n| "this is message # #{n}"}
  end
end
