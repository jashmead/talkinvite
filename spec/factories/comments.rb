# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    person
    talk

    sequence(:comment_text) { |n| "comment #{n}"}
  end
end
