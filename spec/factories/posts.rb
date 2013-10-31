# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    person_id 1
    talk_id 1
    service_type "talkinvite"
    service_notes "{}"
    post_type "announce"
    post_message "let's talk"
  end
end
