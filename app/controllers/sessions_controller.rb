class SessionsController < ApplicationController
  def new
  end

  def create
    # could make friendlier by allowing name or email (use presence of '@' to disambiguate)
    person = Person.find_by(email: params[:session][:email].downcase)
    logger.debug("SessionsController.create: #{person.inspect}") #DDT
    if person && person.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in person
      redirect_to person
    else
      flash.now[:error] = 'Invalid email/password combination. Please try again.'
      render 'new'
    end
  end

  def destroy
  end
end
