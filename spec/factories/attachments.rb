# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    user_id 1
    name "MyString"
    description "MyText"
    file_type "MyString"
    pathname "MyString"
    attachable_type "MyString"
    attachable_id 1
  end
end
