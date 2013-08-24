# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    tagable_type "MyString"
    tabable_id 1
    tag_type "MyString"
    tag "MyString"
  end
end
