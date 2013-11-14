## Sessions controller has no model

class SessionsController < ApplicationController

  # dummy out the search_fields; should never be searching this any way
  def search_fields
    []
  end

  def new
    ## 'self' is pretty big
    ## logger.debug("SessionsController.new: self: #{self.inspect}") #DDT
  end

  def create
    ## logger.debug("SessionsController.create: self: #{self.inspect}") #DDT

    person = Person.find_by(email: params[:session][:email].downcase)
    ##  logger.debug("SessionsController.create: person: #{person.inspect}") #DDT

    if person && person.authenticate(params[:session][:password])
      ##  logger.debug("SessionsController.create: email found: #{person.email.inspect}") #DDT

      # Sign the user in and redirect to the user's show page.
      sign_in person
      # why redirect to 'person' when we have no valid person?
      redirect_back_or person
    else
      # email not a method or attribute of person?
      # logger.debug("SessionsController.create: email not found: #{person.email.inspect}") #DDT

      flash.now[:error] = 'Invalid email/password combination. Please try again.'
      render 'new'
    end
  end

  # specialized destroy, since destroy does not mean here what it normally does
  def destroy
    ## logger.debug("SessionsController.destroy: self: #{self.inspect}") #DDT
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
