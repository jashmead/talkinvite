# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :help do
    name "HelpName"
    title "Help Title"
    description "Help Text"
    help_type "page"
  end
end
