## what context are these functions running in?
module SessionsHelper

  def sign_in(person)
    logger.debug("Sign in: person: #{person.inspect}") #DDT

    remember_token = Person.new_remember_token

    # normal format of cookies is cookies[:key] = { value: value, expires: expire_date }
    #   but, if assigning to cookies.permanent, get expires in 20 years
    #   put unencrypted form of remember_token in the person's cookie:
    cookies.permanent[:remember_token] = remember_token  

    #   save encrypted form to the database record:
    person.update_attribute[:remember_token, Person.encrypt(remember_token)]

    # add a current person attribute to the current object (a controller)
    # this is really an invocation of the 'current_person=' attribute writer
    self.current_person = person
  end

  ## how is current person being set & passed along?
  def signed_in?
    logger.debug("signed_in? current_person: #{current_person.inspect}") #DDT
    ! current_person.nil?
  end

  # why is this squib needed?
  def current_person=(person)
    # stores variable for later use
    # any reason for @current_person versus self.current_person?
    @current_person = person
  end

  # this won't work! apparently doesn't carry thru to next page
  ##  def current_person
  ##    @current_person
  ##  end
  # instead use:
  def current_person
    logger.debug("current_person: current_person: #{@current_person.inspect}") # DDT

    remember_token = Person.encrypt(cookies[:remember_token])

    # the following syntax fails with a PostgreSQL error
    # @current_person ||= Person.find_by( :remember_token, remember_token )
    ## PG::InvalidTextRepresentation: ERROR:  invalid input syntax for type boolean: "remember_token"
    ## LINE 1: SELECT  "people".* FROM "people"  WHERE ('remember_token') L...
    ## : SELECT  "people".* FROM "people"  WHERE ('remember_token') LIMIT 1

    # have to spell out the find_by_remember_token
    @current_person ||= Person.find_by_remember_token( cookies[:remember_token] )
  end

end
