# Read about factories at https://github.com/thoughtbot/factory_girl
# tutorial says to delete this

FactoryGirl.define do
  factory :relationship do
    from_person_id 1
    to_person_id 1
    rel_type "MyString"
  end
end
