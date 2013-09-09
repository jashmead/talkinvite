def sign_in(person, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = Person.new_remember_token
    cookies[:remember_token] = remember_token
    person.update_attribute(:remember_token, person.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: person.email
    fill_in "Password", with: person.password
    click_button "Sign in"
  end
end
