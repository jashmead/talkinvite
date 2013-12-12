# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    person 
    talk
    routing "message"
    post_type "announce"
    post_message "let's talk"
  end
end
