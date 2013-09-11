# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    summary "MySummary"
    description "MyDescription"
    person
  end
end
