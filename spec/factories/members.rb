# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    talk
    person

    rsvp_status "accepted"
    member_type ""
  end
end
