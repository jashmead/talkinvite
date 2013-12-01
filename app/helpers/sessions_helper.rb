## what context are these functions running in?
## SessionsHelper is pulled in via an explicit "include SessionsHelper" in application_controller.rb
module SessionsHelper

  ##  this won't work! apparently doesn't carry thru to next page
  ##    def current_person
  ##      @current_person
  ##    end
  ##  instead use:

  # guesswork as to how to best handle anonymous
  def anonymous
    # logger.debug("SessionsHelper.anonymous")
    @anonymous = Person.find_by_name('anonymous')
  end

  # http://fortawesome.github.io/Font-Awesome/cheatsheet/
  # iconify spotted as complex by codeclimate 10/29/13, complexity 29, 11/22/13 - complexity 30
  def iconify (icon_name)   # currently action_name (preferred as more specific) or controller_name 

    icon_name_s = icon_name.to_s

    # all those icons that map directly to a font-awesome name
    icon_array = [ 
        'ban', 'beer', 'calendar', 'camera', 'check', 'coffee', 
        'comment', 'comments', 'facebook', 'film', 'glass', 
        'home', 'info', 'instagram', 'pencil', 'pinterest', 
        'print', 'random', 'reply', 'search', 'share', 
        'sitemap', 'skype', 'sort', 'tag', 'tags', 
        'trash', 'twitter'
    ]

    if icon_array.index icon_name_s 
      klasses = 'fa-' + icon_name_s
    else
      # could replace the 'case' with a hash; however case seems a bit clearer for case when mapping multiple actions into a single icon
      klasses = case icon_name_s
	      # in alphabetic order of action_name
	      when 'about'
	        'fa-dot-circle-o'
	      when 'cancel'
	        'fa-ban'
	      when 'contact'
	        'fa-envelope-o'
	      when 'credit', 'credits'
	        'fa-heart'
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
	      when 'location', 'venue'  # venue can show up here even without being a table!
	        'fa-location-arrow'
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
	      when 'sign_in'
	        'fa-sign-in'
	      when 'sign_out'
	        'fa-sign-in fa-flip-vertical'
	      when 'sign_up'
	        'fa-sign-in fa-rotate-270'
	      when 'start'
	        'fa-home'
	      when 'talk'
	        'fa-comment-o'
	      when 'talks'
          'fa-comments-o'
	      when 'wine'
	        'fa-glass'
	      when /^my_/
	        'fa-user'
	      else
          # leave function entirely...
	        return ''
	    end
    end

    return "<i class=\"fa #{klasses}\" ></i>"

  end

  # the supplied default is 'person', so will turn into 'redirect_to person', which is what we had before
  def redirect_back_or(default)
    logger.debug("SessionsHelper: redirect_or_back: default: #{default.inspect}, session[:return_to]: #{session[:return_to].inspect}")
    # TBD:  use a redirect to :back?
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)  # TBD: will this take effect after a redirect_to?
  end

  def store_location (url = nil)
    url ||= request.url
    logger.debug("SessionsHelper: store_location: #{url.inspect}, request.get?: #{request.get?}")
    session[:return_to] = url if request.get?
  end

  # stub out admin? when in test environment due a problem with 'devise'
  def admin?
    # TBD:  why is current_person failing
    # logger.debug("SessionsHelper.admin?: #{person_signed_in?.inspect}, #{current_person.inspect}")
    if ENV["RAILS_ENV"] != "test"
      person_signed_in? && current_person.admin?
    else
      true
    end
  end

  # stub out sub? when in test environment due a problem with 'devise'
  def sub?
    if ENV["RAILS_ENV"] != "test"
      signed_in? && current_person.sub?
    else
      true
    end
  end

  # TBD:  how to get person_sign_in? (devise function) to work when in test environment
  def signed_in?
    if ENV["RAILS_ENV"] != "test"
      person_signed_in? 
    else
      true
    end
  end
    

  # useful links in alphabetical order:

  def root_link
    link_to( "<i class=\"fa fa-comments-o fa-lg\"></i>&nbsp;Home".html_safe, root_path )
  end

  # settings_link not really needed at this point:  leave code in till sure of this, however
  def settings_link
    # TBD:  test to see if we are signed in first
    link_to( 
      "#{iconify(:settings)}&nbsp;Settings".html_safe,
      edit_person_registration_path, 
      method: :get,
      'class' => 'ui-btn-right' # force button to the right side of the header, leaving space for the back button
    )
  end

  # note:  fixed sign_in, sign_out, sign_up to work with devise
  def sign_in_link
    # note:  could test to see if we aren't already signed in, but seems no point
    # TBD:  make sure that all references to sign_in have it as a dialog
    link_to( "#{iconify(:sign_in)}&nbsp;Sign In".html_safe, new_person_session_path, 'data-rel' => 'dialog')
  end

  # sign_out link only available on settings & related pages
  def sign_out_link
    # note: could test to see if we aren't already signed in, but seems no point
    # note: icon is the vertical flip of the sign-in icon
    link_to( 
      "Sign Out&nbsp;#{iconify(:sign_out)}".html_safe, 
      destroy_person_session_path, 
      method: :delete,
      'class' => 'ui-btn-right' # force button to the right side of the header, leaving space for the back button
    )
  end

  def sign_up_link
    # note:  could test to see if we aren't already signed in, but seems no point
    # logger.debug("SessionsHelper.sign_up_link: iconify(sign_up): #{iconify(:sign_up)}")
    link_to( "#{iconify(:sign_up)}</i>&nbsp;New Account".html_safe, new_person_registration_path)
  end

end
