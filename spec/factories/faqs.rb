# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :faq do
    sequence(:question)  { |n| "Question# #{n}" }
    sequence(:answer)  { |n| "Answer# #{n}" }


  end
end
