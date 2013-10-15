# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    person
    talk
    note_type "announce"
    note_text "what's it all about, Alfie?"
  end
end
