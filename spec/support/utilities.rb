# TBD: eliminate all references to remember_token?
# NOTE:  person_email & person_password are the correct ids for the sign in fields

include ApplicationHelper

# TBD: is valid_sign_in in use?
def valid_sign_in(person)
  fill_in "person_email",    with: person.email
  fill_in "person_password", with: person.password
  click_button "Sign In"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

# sign_in is not working, inspite of being cloned from tutorial
def sign_in(person, options={})
  # TBD: visit sign_in_path is not working:  no sign_in_path, no visit; hunh?
  visit sign_in_path
  # save_and_open_page
  fill_in 'person_email',    with: person.email
  fill_in 'person_password', with: person.password
  click_button "Sign In"
end

# stub method to let other tests past
# TBD:  why is this needed?  
#   -- see https://github.com/plataformatec/devise/blob/master/lib/devise/controllers/helpers.rb for more
def person_signed_in?
  true
end

=begin
# http://www.tamingthemindmonkey.com/2011/11/07/capybara-matchers-and-scoping-in-view-specs
# -- didn't solve the problem but may help at some later point...
def rendered
  # Using @rendered variable, which is set by the render-method.
  Capybara.string(@rendered)
end
=end
