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
  # split of sets of paths into the private methods met with codeclimate's approval,
  #   -- as they put it, 'woot!'
  #   -- and, perhaps more importantly, it seems to make the code more maintainable, 'woot!woot!'

  def sitemap
    store_location

    # note: icons could be included, but do not seem to add much
    # note: tried showing unavailable pages as 'sans link', results not particularly attractive

    # TBD:  My Talks, My Messsages, Current Messages
    # TBD:  Maps, Calendars, Tags & Topics, Friends & Groups, Attachments, Venues
    # TBD:  add a current_message element in?
    
    @routes = talk_routes + user_routes + message_routes + common_routes + boring_routes + admin_routes 

  end

  private

    # note: the paths have to be computed, so can't use static arrays defined in the StaticPagesController class
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
