include ApplicationHelper

def valid_sign_in(person)
  fill_in "session_email",    with: person.email
  fill_in "session_password", with: person.password
  click_button "Sign In"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

# sign_in is not working, inspite of being cloned from tutorial
def sign_in(person, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = Person.new_remember_token
    cookies[:remember_token] = remember_token
    person.update_attribute(:remember_token, Person.encrypt(remember_token))
  else
    # visit sign_in_path is not working:  no sign_in_path, no visit; hunh?
    visit sign_in_path
    fill_in "session_email",    with: person.email
    fill_in "session_password", with: person.password
    click_button "Sign In"
  end
end

=begin
# http://www.tamingthemindmonkey.com/2011/11/07/capybara-matchers-and-scoping-in-view-specs
# -- didn't solve the problem but may help at some later point...
def rendered
  # Using @rendered variable, which is set by the render-method.
  Capybara.string(@rendered)
end
=end
