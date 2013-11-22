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
  def sitemap
    store_location
    
    # logger.debug("StaticPagesController.sitemap:  current_talk: #{current_talk.inspect}")

    # note: icons could be included, but do not seem to add much
    # note: tried showing unavailable pages as 'sans link', results not particularly attractive
    # fourth field is a flag saying when to show; if not present, show
    # TBD:  Friends, Groups, Venues, Calendars
    @routes = [
      [ home_path, 'Home', 'people', signed_in? ],
      [ settings_path, 'Settings', 'people', signed_in? ],
      [ profile_path, 'Profile', 'people', signed_in? ],
      [ change_password_path, 'Change Password', 'people', signed_in? ],
      [ control_talk_path(current_talk), "Current Talk", 'talks', signed_in? && current_talk ],
      [ new_talk_path, 'Create Talk', 'talks', signed_in? ],
      [ my_messages_path, 'My Messages', 'messages', signed_in? ],
      [ signin_path, 'Sign In', 'sessions', ! signed_in? ],
      [ signup_path, 'New Account', 'people', ! signed_in? ],
      [ reset_password_path, 'Reset Password', 'sessions', ! signed_in? ],
      # [ search_people_path, 'Search for People', 'people' ],
      [ search_path, 'Search for Talks', 'talks' ],
      [ helps_path, 'List of Help Pages' , 'helps' ],
      [ new_help_path, 'New Help' , 'helps', admin? ],
      [ faqs_path, 'FAQs' , 'faqs' ],
      [ new_faq_path, 'New FAQ' , 'faqs', admin? ],
      [ credits_path, 'Credits' , 'credits' ],
      [ new_credit_path, 'New Credit' , 'credits', admin? ],
      [ static_pages_about_path, 'About' , 'static_pages' ],
      [ static_pages_contact_path, 'Contact' , 'static_pages' ],
      [ static_pages_privacy_path, 'Privacy' , 'static_pages' ],
      [ static_pages_sitemap_path, 'Site Map', 'static_pages' ]
    ]

  end

end
