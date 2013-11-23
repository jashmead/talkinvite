# Static Pages
#
# TBD:  add in topics pages/routes -- i.e. stuff to talk about

class StaticPagesController < ApplicationController

  # dummy out the search_fields; should never be searching this any way
  def search_fields
    []
  end

  def feet_center
    feet_for_static_pages
  end

  def about
  end

  def contact
  end

  def privacy
  end

  # Sitemap is basic entry point for development & testing; 
  #   -- pages here are the 'key' pages
  #   -- all pages are accessible from here or in one or two hops
  #   -- may make a reasonable start page as well
  # Codeclimate thinks the array with flags approach has complexity 47!
  def sitemap
    store_location
    
    # logger.debug("StaticPagesController.sitemap:  current_talk: #{current_talk.inspect}")

    # note: icons could be included, but do not seem to add much
    # note: tried showing unavailable pages as 'sans link', results not particularly attractive
    # fourth field is a flag saying when to show; if not present, show
    # TBD:  Maps, Calendars, Tags & Topics, Friends & Groups, Attachments, Venues
    # TBD:  add a current_message element in?
    
    @routes = []

    if signed_in?
      @routes += [
        [ home_path, 'Home', 'people' ],
        [ settings_path, 'Settings', 'people' ],
        [ profile_path, 'Profile', 'people' ],
        [ change_password_path, 'Change Password', 'people' ],
        [ new_talk_path, 'Create Talk', 'talks' ],
        [ my_messages_path, 'My Messages', 'messages' ],
        [ signin_path, 'Sign In', 'sessions', ! signed_in? ],
        [ signup_path, 'New Account', 'people', ! signed_in? ],
        [ search_people_path, 'Search for People', 'people' ]
      ]
    else 
      @routes.push([ reset_password_path, 'Reset Password', 'sessions' ])
    end

    if current_talk
      @routes.push([ control_talk_path(current_talk), "Current Talk", 'talks' ])
    end
    
    if admin?
      @routes += [
        [ new_help_path, 'New Help' , 'helps' ],
        [ new_faq_path, 'New FAQ' , 'faqs' ],
        [ new_credit_path, 'New Credit' , 'credits' ]
      ]
    end

    @routes += [
      [ search_path, 'Search for Talks', 'talks' ],
      [ helps_path, 'List of Help Pages' , 'helps' ],
      [ faqs_path, 'FAQs' , 'faqs' ],
      [ credits_path, 'Credits' , 'credits' ],
      [ static_pages_about_path, 'About' , 'static_pages' ],
      [ static_pages_contact_path, 'Contact' , 'static_pages' ],
      [ static_pages_privacy_path, 'Privacy' , 'static_pages' ],
      [ static_pages_sitemap_path, 'Site Map', 'static_pages' ]
    ]

  end

end
