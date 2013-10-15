# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :social do
    person
    talk
    social_type "invite"
    social_text "social posting"
  end
end
