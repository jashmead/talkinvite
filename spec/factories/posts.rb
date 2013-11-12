# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    person 
    talk
    service_type "talkinvite"
    service_notes "{}"
    post_type "announce"
    post_message "let's talk"
  end
end
