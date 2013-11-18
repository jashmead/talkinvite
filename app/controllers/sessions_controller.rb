## Sessions controller has no model

# TBD:  add in reset password form

# TBD:  should we be using 'reset_session' (see http://ipc.webitedesigncost.com/security.html)  on a successful login?

class SessionsController < ApplicationController

  # dummy out the search_fields; should never be searching this any way
  def search_fields
    []
  end

  def new
  end

  # TBD:  allow signin by name as well as by email: fix this code & the form
  def create
    person = Person.find_by(email: params[:session][:email].downcase)

    if person && person.authenticate(params[:session][:password])
      # Sign the user in
      sign_in person

      # TBD:  make redirect on signin to to their last-viewed page?
      redirect_back_or person
    else
      flash.now[:error] = 'Invalid email/password combination. Please try again.'
      render 'new'
    end
  end

  # no one is logged in; they are requesting a reset for a specific person
  def reset_password
  end

  # specialized destroy, since destroy does not mean here what it normally does
  def destroy
    signout
    redirect_to root_url
  end

  # TBD: can we specify the method (i.e. 'delete') in the button itself?
  # note: sayonara is called from a signout button via 'get', just maps to the destroy
  # note: can't just call 'destroy' here because this is a 'get' method, that a 'delete' method
  # TBD: will codeclimate regard even this much duplication (with 'destroy') as too much?
  def sayonara
    signout
    redirect_to root_url
  end

end
