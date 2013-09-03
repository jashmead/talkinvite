# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    # JRU = J. Random User
    name "JRU"
    email { "#{name}@talkinvite.com" }
    password "foobar"
    password_confirmation "foobar"

    # FactoryGirl recommends that the base instance have least possible # of fields
    # about_me, screen_name, settings, & person_type are talkinvite addons
    # about_me "about jru"
    # screen_name "jru"
    # settings ""
    # person_type "reg"

    # don't need anon or site people:  those two are singletons & already wired in
    factory :sub do
      person_type 'sub'
    end
    factory :admin do
      person_type 'admin'
    end

  end
end
