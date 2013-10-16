# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calendar do
    name "MyCalendar"
    description "MyHistory"
    chronometry "{}"
    settings "{}"
    history "{}"
  end
end
