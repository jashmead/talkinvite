class SessionsController < ApplicationController

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

  def destroy
    ## logger.debug("SessionsController.destroy: self: #{self.inspect}") #DDT
    sign_out
    redirect_to root_url
  end

end
