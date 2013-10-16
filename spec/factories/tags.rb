# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    tag_type "tag"
    tagable_type "talks"
    tagable_id "1"  # placeholder, till we can insist on a talk, venue, or person being passed in
  end
end
