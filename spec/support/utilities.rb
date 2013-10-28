include ApplicationHelper

def valid_signin(person)
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
    # visit signin_path is not working:  no signin_path, no visit; hunh? -- and they show up at the top level in the gottalk spec
    visit signin_path
    fill_in "session_email",    with: person.email
    fill_in "session_password", with: person.password
    click_button "Sign in"
  end
end
