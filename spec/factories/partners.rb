# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :partner do
    talk
    person

    rsvp_status "yes"
    partner_type "partner"
  end
end
