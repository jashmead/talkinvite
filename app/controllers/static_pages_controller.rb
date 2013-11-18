# Static Pages
#
=begin
  TBD:  add in topics pages/routes -- i.e. stuff to talk about
=end

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

  # Sitemap is basic entry point for development & testing; all pages are accessible from here or in one or two hops
  # may make a reasonable start page as well
  def sitemap
    store_location
    
    logger.debug("StaticPagesController.sitemap:  current_talk: #{current_talk.inspect}")

    # TBD:  put all options in, but leave disabled?
    # TBD:  include icons?
    if signed_in?
      @routes = [
        [ home_path, 'Home', 'people' ],
        [ settings_path, 'Settings', 'people' ],
        [ profile_path, 'Profile', 'people' ],
        [ change_password_path, 'Change Password', 'people' ]
      ]
      @routes.push( [ control_talk_path(current_talk), "Current Talk", 'talks' ] ) if current_talk
      @routes += [
        [ new_talk_path, 'Create Talk', 'talks' ],
        [ my_messages_path, 'My Messages', 'messages' ]
      ]
    else 
      @routes = [
        [ signin_path, 'Sign In', 'sessions' ],
        [ signup_path, 'New Account', 'people' ],
        [ reset_password_path, 'Reset Password', 'sessions' ]
      ]
    end

    @routes += [
      [ search_people_path, 'Search for People', 'people' ],
      [ search_path, 'Search for Talks', 'talks' ],
      [ helps_path, 'List of Help Pages' , 'helps' ]
    ]
    @routes.push( [ new_help_path, 'New Help' , 'helps' ] ) if admin?

    @routes.push( [ faqs_path, 'FAQs' , 'faqs' ] )
    @routes.push( [ new_faq_path, 'New FAQ' , 'faqs' ] ) if admin?

    @routes.push( [ credits_path, 'Credits' , 'credits' ] )
    @routes.push( [ new_credit_path, 'New Credit' , 'credits' ] ) if admin?

    @routes += [
      [ static_pages_about_path, 'About' , 'static_pages' ],
      [ static_pages_contact_path, 'Contact' , 'static_pages' ],
      [ static_pages_privacy_path, 'Privacy' , 'static_pages' ],
      [ static_pages_sitemap_path, 'Site Map', 'static_pages' ]
    ]

  end

end
