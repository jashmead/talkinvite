## what context are these functions running in?
module SessionsHelper

  ##  this won't work! apparently doesn't carry thru to next page
  ##    def current_person
  ##      @current_person
  ##    end
  ##  instead use:
  def current_person
  ##  logger.debug("SessionsHelper.current_person: current_person: #{@current_person.inspect}") # DDT

    encrypted_remember_token = Person.encrypt(cookies[:remember_token])

    # the following syntax fails with a PostgreSQL error
    # @current_person ||= Person.find_by( :remember_token, remember_token )
    ## PG::InvalidTextRepresentation: ERROR:  invalid input syntax for type boolean: "remember_token"
    ## LINE 1: SELECT  "people".* FROM "people"  WHERE ('remember_token') L...
    ## : SELECT  "people".* FROM "people"  WHERE ('remember_token') LIMIT 1

    # have to spell out the find_by_remember_token
    @current_person ||= Person.find_by_remember_token( encrypted_remember_token )

    ## logger.debug("SessionsHelper.current_person: current_person: #{@current_person.inspect}") #DDT
    ## @current_person #DDT -- needed to make sure return value is correct
  end

  # why is this squib needed?
  def current_person=(person)
    # stores variable for later use
    # any reason for @current_person versus self.current_person?
  ##  logger.debug("SessionsHelper.current_person=: current_person: #{@current_person.inspect}") #DDT
    @current_person = person
  end

  def current_person?(person)
    person == current_person ## not @current_person?
  end

  def sign_in(person)
    remember_token = Person.new_remember_token

    # normal format of cookies is cookies[:key] = { value: value, expires: expire_date }
    #   but, if assigning to cookies.permanent, get expires in 20 years
    #   put unencrypted form of remember_token in the person's cookie:
    cookies.permanent[:remember_token] = remember_token  

    #   save ENCRYPTED form to the database record:
    person.update_attribute(:remember_token, Person.encrypt(remember_token))

    # add a current person attribute to the current object (a controller)
    # this is really an invocation of the 'current_person=' attribute writer
    self.current_person = person
  end

  ## current_person is a method, @current_person is an attribute -- admittedly a fuzzy distinction in Ruby
  ## see if we are signed in currently
  def signed_in?
    logger.debug("SessionsHelper.signed_in?: current_person: #{current_person.inspect}")
    !current_person.nil?
  end

  ## force person to be signed in, whether they are not currently
  def signed_in_person
    unless signed_in?
      ## store location defined in sessions_helper.rb
      store_location
      redirect_to signin_url, notice:  'Please sign in.' 
    end
  end

  def sign_out
  ##  logger.debug("SessionsHelper.sign_out: current_person: #{self.current_person.inspect}") # DDT
    
    ## self.current_person = Person.find_by :name, 'anonymous'    ## why does this fail when it hits PostgreSQL?
    self.current_person = Person.where("name = ?", 'anonymous').first

    cookies.delete(:remember_token)
  end

  # the supplied default is 'person', so will turn into 'redirect_to person', which is what we had before
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  ## placeholders for admin & sub booleans; seem to work fine
  def admin?
    current_person && current_person.admin
  end

  def sub?
    current_person && current_person.sub
  end

  # useful links in alphabetical order:

  def root_link
    link_to( "<i class=\"fa fa-comments-o fa-lg\"></i>&nbsp;&nbsp;Home".html_safe, root_path )
  end

  def settings_link
    # TBD:  test to see if we are signed in first
    link_to( "<i class=\"fa fa-cogs fa-lg\"></i>&nbsp;&nbsp;Settings".html_safe, settings_path)
  end

  def sign_out_link
    # TBD:  test to see if we are signed in first
    # icon is the vertical flip of the sign-in icon
    link_to( "Sign Out&nbsp;&nbsp;<i class=\"fa fa-sign-in fa-flip-vertical fa-lg\"></i>".html_safe, signout_path, method: :delete)
  end

  def signin_link
    # TBD:  test to see if we are signed in first
    link_to( "<i class=\"fa fa-sign-in fa-lg\"></i>&nbsp;&nbsp;Sign In".html_safe, signin_path, 'data-rel' => 'dialog')
  end

  def signup_link
    # TBD:  test to see if we are signed in first
    link_to( "<i class=\"fa fa-sign-in fa-rotate-270 fa-lg\"></i>&nbsp;&nbsp;Sign Up".html_safe, signup_path, 'data-rel' => 'dialog')
  end

end
