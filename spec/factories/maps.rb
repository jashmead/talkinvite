# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :map do
    person

    talk
    name "MyMap"
    sequence(:description) { |n| "map description #{n}"}

    geometry "{}"
    settings "{}"
    history "{}"
  end
end
