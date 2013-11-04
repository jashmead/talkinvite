## what context are these functions running in?
module SessionsHelper

  ##  this won't work! apparently doesn't carry thru to next page
  ##    def current_person
  ##      @current_person
  ##    end
  ##  instead use:
  def current_person
    logger.debug("SessionsHelper.current_person: current_person: #{@current_person.inspect}") # DDT

    encrypted_remember_token = Person.encrypt(cookies[:remember_token])

    # the following syntax fails with a PostgreSQL error
    # @current_person ||= Person.find_by( :remember_token, remember_token )
    ## PG::InvalidTextRepresentation: ERROR:  invalid input syntax for type boolean: "remember_token"
    ## LINE 1: SELECT  "people".* FROM "people"  WHERE ('remember_token') L...
    ## : SELECT  "people".* FROM "people"  WHERE ('remember_token') LIMIT 1

    # have to spell out the find_by_remember_token
    @current_person ||= Person.find_by_remember_token( encrypted_remember_token )

    logger.debug("SessionsHelper.current_person: current_person: #{@current_person.inspect}") #DDT
    @current_person #DDT -- needed to make sure return value is correct
  end

  # why is this squib needed?
  def current_person=(person)
    # stores variable for later use
    # any reason for @current_person versus self.current_person?
    logger.debug("SessionsHelper.current_person=: current_person: #{@current_person.inspect}") #DDT
    @current_person = person
  end

  def current_person?(person)
    logger.debug("SessionsHelper.current_person?: current_person: #{@current_person.inspect}") #DDT
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
    ## logger.debug("SessionsHelper.signed_in?: current_person: #{current_person.inspect}")
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

  # http://fortawesome.github.io/Font-Awesome/cheatsheet/
  # iconify spotted as complex by codeclimate 10/29/13, complexity 29 -- replace with hash? -- started with minor cleanup
  def iconify (action_name) 

    action_s = action_name.to_s

    klasses = case action_s
      # all those icons that map directly to a font-awesome name
      when 'ban', 'beer', 'calendar', 'camera', 'check', 'coffee', 'facebook', 'film', 'glass', 'home', 'info', 'instagram',
        'pencil', 'pinterest', 'print', 'random', 'reply', 'search', 'share', 'sitemap', 'skype', 'sort', 
        'tag', 'tags', 'trash', 'twitter'
        'fa-' + action_s
      # rest in alphabetic order of action_name
      when 'about'
        'fa-dot-circle-o'
      when 'cancel'
        'fa-ban'
      when 'comment', 'talk'
        'fa-comment-o'
      when 'comments', 'talks'
        'fa-comments-o'
      when 'contact'
        'fa-envelope-o'
      when 'data', 'table'
        'fa-table'
      when 'delete', 'destroy'
        'fa-minus-cirle'
      when 'edit'
        'fa-pencil'
      when 'google_plus'
        'fa-google-plus'
      when 'help', 'helps'
        'fa-question'
      when 'message'
        'fa-bolt'
      when 'new'
        'fa-plus-circle'
      when 'person'
        'fa-user'
      when 'privacy'
        'fa-eye'
      when 'settings'
        'fa-cog'
      when 'signin'
        'fa-sign-in'
      when 'signout'
        'fa-sign-in fa-flip-vertical'
      when 'signup'
        'fa-sign-in fa-rotate-270'
      when 'start'
        'fa-home'
      when 'location', 'venue'  # venue can show up here even without being a table!
        'fa-location-arrow'
      when 'wine'
        'fa-glass'
      when /^my_/
        'fa-user'
      else
        return ''
    end

    return "<i class=\"fa #{klasses}\" ></i>"
  end

  def signout
  ##  # logger.debug("SessionsHelper.signout: current_person: #{self.current_person.inspect}") # DDT
    
    ## self.current_person = Person.find_by :name, 'anonymous'    ## why does this fail when it hits PostgreSQL?
    self.current_person = Person.where("name = ?", 'anonymous').first

    cookies.delete(:remember_token)
  end

  # the supplied default is 'person', so will turn into 'redirect_to person', which is what we had before
  def redirect_back_or(default)
    # logger.debug("AH: SessionsHelper: redirect_or_back: default: #{default.inspect}, session[:return_to]: #{session[:return_to].inspect}")
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    # logger.debug("AH: SessionsHelper: store_location: #{request.url.inspect}, request.get?: #{request.get?}")
    session[:return_to] = request.url if request.get?
  end

  ## placeholders for admin & sub booleans; seem to work fine
  def admin?
    # logger.debug("admin?: #{signed_in?.inspect}, #{current_person.inspect}")
    signed_in? && current_person.admin
  end

  def sub?
    signed_in? && current_person.sub
  end

  # useful links in alphabetical order:

  def root_link
    link_to( "<i class=\"fa fa-comments-o fa-lg\"></i>&nbsp;&nbsp;Home".html_safe, root_path )
  end

  # settings_link not really needed at this point:  leave code in till sure of this, however
  def settings_link
    # TBD:  test to see if we are signed in first
    link_to( 
      "#{iconify(:settings)}&nbsp;&nbsp;Settings".html_safe,
      settings_path, 
      method: :get,
      'class' => 'ui-btn-right' # force button to the right side of the header, leaving space for the back button
    )
  end

  # signout link only available on settings & related pages
  def signout_link
    # TBD:  test to see if we are signed in first
    # icon is the vertical flip of the sign-in icon
    link_to( 
      "Sign Out&nbsp;&nbsp;#{iconify(:signout)}".html_safe, 
      signout_path, 
      method: :delete,
      'class' => 'ui-btn-right' # force button to the right side of the header, leaving space for the back button
    )
  end

  def signin_link
    # TBD:  test to see if we are signed in first
    link_to( "#{iconify(:signin)}&nbsp;&nbsp;Sign In".html_safe, signin_path, 'data-rel' => 'dialog')
  end

  def signup_link
    # TBD:  test to see if we are signed in first
    ## logger.debug("SessionsHelper.signup_link: iconify(signup): #{iconify(:signup)}")
    link_to( "#{iconify(:signup)}</i>&nbsp;&nbsp;Sign Up".html_safe, signup_path, 'data-rel' => 'dialog')
  end

end
