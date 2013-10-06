# Read about factories at https://github.com/thoughtbot/factory_girl
<<<<<<< HEAD

FactoryGirl.define do
  factory :relationship do
    follower_id 1
    followed_id 1
=======
# tutorial says to delete this

FactoryGirl.define do
  factory :relationship do
    from_person_id 1
    to_person_id 1
    rel_type "MyString"
>>>>>>> relationships
  end
end
