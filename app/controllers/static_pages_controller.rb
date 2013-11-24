# Static Pages
#

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

  # TBD: make contact a form, setting up email calls
  def contact
  end

  def privacy
  end

  # Sitemap is basic entry point for development & testing; 
  #   -- pages here are the 'key' pages
  #   -- all pages are accessible from here or in one or two hops
  #   -- may make a reasonable start page as well
  # Codeclimate thinks the array with flags approach has complexity 47! 
  # note:  currently trying to bring the complexity down; 
  #   -- may let it go back up once once we understand the complexity metric
  #     -- especially if we are seeing performance problems with this function
  #       -- *and* see it is being called often enough that we care
  #   -- break out into arrays of arrays + a few +='s brought the complexity down to 32,
  #     -- getting our A rating back

  def sitemap
    store_location

    # note: icons could be included, but do not seem to add much
    # note: tried showing unavailable pages as 'sans link', results not particularly attractive
    # fourth field is a flag saying when to show; if not present, show
    # TBD:  My Talks, My Messsages, Current Messages
    # TBD:  Maps, Calendars, Tags & Topics, Friends & Groups, Attachments, Venues
    # TBD:  add a current_message element in?
    
    # note: the paths have to be local to the sitemap method; making the routes variables class variables failed.
    admin_routes = [
      [ new_help_path, 'New Help' , 'helps' ],
      [ new_faq_path, 'New FAQ' , 'faqs' ],
      [ new_credit_path, 'New Credit' , 'credits' ]
    ]
    base_routes = [
      [ search_path, 'Search for Talks', 'talks' ],
      [ helps_path, 'List of Help Pages' , 'helps' ],
      [ faqs_path, 'FAQs' , 'faqs' ],
      [ credits_path, 'Credits' , 'credits' ],
      [ static_pages_about_path, 'About' , 'static_pages' ],
      [ static_pages_contact_path, 'Contact' , 'static_pages' ],
      [ static_pages_privacy_path, 'Privacy' , 'static_pages' ],
      [ static_pages_sitemap_path, 'Site Map', 'static_pages' ]
    ]
    current_talk_routes = [ [ control_talk_path(TalksController.current_talk), "Current Talk", 'talks' ] ]
    signed_in_routes = [
      [ home_path, 'Home', 'people' ],
      [ settings_path, 'Settings', 'people' ],
      [ profile_path, 'Profile', 'people' ],
      [ change_password_path, 'Change Password', 'people' ],
      [ new_talk_path, 'Create Talk', 'talks' ],
      [ my_messages_path, 'My Messages', 'messages' ],
      [ search_people_path, 'Search for People', 'people' ]
    ]
    not_signed_in_routes = [
      [ signin_path, 'Sign In', 'sessions' ],
      [ signup_path, 'New Account', 'people' ],
      [ reset_password_path, 'Reset Password', 'sessions' ]
    ]

    @routes = signed_in? ? signed_in_routes : not_signed_in_routes

    @routes += current_talk_routes if TalksController.current_talk
    
    @routes += admin_routes if admin?

    @routes += base_routes

  end

end
