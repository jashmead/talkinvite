# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    sequence(:summary)  { |n| "About #{n}" }
    sequence(:description) { |n| "description_#{n}"}

    person    # how does this work? how is 'person' set?  why is 'person' not being returned?
  end
end
