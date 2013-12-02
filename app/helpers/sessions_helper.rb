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
  # iconify again spotted as complex by codeclimate 12/1/13, complexity 30
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

    icon_hash = {
      'about' => 'fa-dot-circle-o',
      'cancel' => 'fa-ban',
      'contact' => 'fa-envelope-o',
      'credit' => 'fa-heart',
      'credits' => 'fa-heart',
      'data' => 'fa-table',
      'table' => 'fa-table',
      'delete' => 'fa-minus-circle',
      'destroy' => 'fa-minus-circle',
      'edit' => 'fa-pencil',
      'google_plus' => 'fa-google-plus',
      'help' => 'fa_question',
      'helps' => 'fa-question',
      'location' => 'fa-location-arrow',
      'venue' => 'fa-location-arrow',
      'message' => 'fa-bolt',
      'new' => 'fa-plus-circle',
      'person' => 'fa-user',
      'privacy' => 'fa-eye',
      'settings' => 'fa-cog',
      'sign_in' => 'fa-sign-in',
      'sign_out' => 'fa-sign-in fa-flip-vertical',
      'sign_up' => 'fa-sign-in fa-rotate-270',
      'start' => 'fa-home',
      'talk' => 'fa-comment-o',
      'talks' => 'fa-comments-o',
      'wine' => 'fa-glass'
    }

    if icon_array.index icon_name_s 
      klasses = 'fa-' + icon_name_s
    elsif icon_hash.key? icon_name_s
      klasses = icon_hash[ icon_name_s ]
    elsif icon_name_s =~ /^my_/
      klasses = 'fa-user'
    else
      return ''
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

  # TBD:  why does person_signed_in not work in test environment?
  def admin?
    begin
      logger.debug("SessionsHelper.admin?: person_signed_in?: #{person_signed_in?.inspect}")
      logger.debug("SessionsHelper.admin?: current_person: #{current_person.inspect}")
      person_signed_in? && current_person && current_person.admin?
    rescue
      logger.debug("SessionsHelper.admin?: unable to figure out if person is admin")
      false
    end
  end

  # TBD:  why does person_signed_in not work in test environment?
  def sub?
    begin
      logger.debug("SessionsHelper.sub?: person_signed_in?: #{person_signed_in?.inspect}")
      logger.debug("SessionsHelper.sub?: current_person: #{current_person.inspect}")
      person_signed_in? && current_person && current_person.sub?
    rescue
      logger.debug("SessionsHelper.sub?: unable to figure out if person is sub")
      false
    end
  end

  # TBD:  why does person_signed_in not work in test environment?
=begin
  def signed_in?
    begin
      logger.debug("SessionsHelper.admin?: person_signed_in?: #{person_signed_in?.inspect}")
      logger.debug("SessionsHelper.admin?: current_person: #{current_person.inspect}")
      person_signed_in? && current_person
    rescue
      logger.debug("SessionsHelper.admin?: unable to figure out if person is signed_in")
      false
    end
  end
=end

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
