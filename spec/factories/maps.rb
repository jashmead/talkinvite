# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :map do
    name "MyMap"
    description "MyLegend"
    geometry "{}"
    settings "{}"
    history "{}"
  end
end
