module SessionsHelper
  def sign_in(person)
    # normal format of cookies is cookies[:key] = { value: value, expires: expire_date }
    #   but, if assigning to cookies.permanent, get expires in 20 years
    cookies.permanent[:remember_token] = person.remember_token  
    # add a current person attribute to the current object (a controller)
    # this is really an invocation of the 'current_person=' attribute writer
    self.current_person = person
  end
  # why is this squib needed?
  def current_person=(person)
    # stores variable for later use
    @current_person = person
  end
  # this won't work! apparently doesn't carry thru to next page
  ##  def current_person
  ##    @current_person
  ##  end
  # instead use:
  def current_person
    # we could also use Person.find_by_remember_token( cookies[:remember_token] )
    @current_person ||= Person.find_by( :remember_token,cookies[:remember_token] )
  end
end
