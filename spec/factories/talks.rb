# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    person    # how does this work? how is 'person' set?  why is 'person' not being returned?

    sequence(:summary)  { |n| "About #{n}" }
    sequence(:description) { |n| "description_#{n}"}

    talk_status "active"
  end
end
