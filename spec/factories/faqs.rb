# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :faq do
    sequence(:question)  { |n| "Question# #{n}" }
    sequence(:answer)  { |n| "Answer# #{n}" }

    factory :help do
      question "How do I X?"
      answer "First do Y"
    end

  end
end
