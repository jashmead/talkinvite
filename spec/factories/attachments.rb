# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    name "name of attachment"
    description "description of attachment"
    attachment_type "image"
    attachable_type "talks"
    attachable_id 1 # replace this with something real
    file_path ""
  end
end
