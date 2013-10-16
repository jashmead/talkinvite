# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ad do
    name "MyName"
    description "MyDescription"
    internal_flag true
    content "MyContent"
    source "MySource"
    strategy "MyStrategy"
    stats "MyStats"
  end
end
