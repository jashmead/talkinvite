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
    # this means they have to be computed; to keep this proc simple, have pushed the computes into private methods, see below

    @routes = talk_routes + user_routes + message_routes + common_routes + boring_routes + admin_routes 

  end

  private

    def admin_routes
      if admin?
        [
          [ new_help_path, 'New Help' , 'helps' ],
          [ new_faq_path, 'New FAQ' , 'faqs' ],
          [ new_credit_path, 'New Credit' , 'credits' ]
        ]
      else
        []
      end
    end

    def boring_routes
      [
        [ helps_path, 'List of Help Pages' , 'helps' ],
        [ faqs_path, 'FAQs' , 'faqs' ],
        [ credits_path, 'Credits' , 'credits' ],
        [ static_pages_about_path, 'About' , 'static_pages' ],
        [ static_pages_contact_path, 'Contact' , 'static_pages' ],
        [ static_pages_privacy_path, 'Privacy' , 'static_pages' ],
        [ static_pages_sitemap_path, 'Site Map', 'static_pages' ]
      ]
    end

    def common_routes
      [
        [ search_path, 'Search for Talks', 'talks' ]
      ]
    end
  
    def message_routes 
      if MessagesController.current_message
        [ [ message_path(MessagesController.current_message), "Current Message", 'messages' ] ]
      else
        []
      end
    end
        
    def talk_routes
      if TalksController.current_talk
        [ [ control_talk_path(TalksController.current_talk), "Current Talk", 'talks' ] ]
      else
        []
      end
    end

    def user_routes
      if signed_in? 
        [
          [ home_path, 'Home', 'people' ],
          [ settings_path, 'Settings', 'people' ],
          [ profile_path, 'Profile', 'people' ],
          [ change_password_path, 'Change Password', 'people' ],
          [ new_talk_path, 'Create Talk', 'talks' ],
          [ my_messages_path, 'My Messages', 'messages' ],
          [ search_people_path, 'Search for People', 'people' ]
        ]
      else
        [
          [ signin_path, 'Sign In', 'sessions' ],
          [ signup_path, 'New Account', 'people' ],
          [ reset_password_path, 'Reset Password', 'sessions' ]
        ]
      end
    end

end
