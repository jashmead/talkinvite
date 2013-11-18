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
    
    # TBD:  put all options in, but leave disabled?
    if signed_in?
      @person = current_person
      @routes = [
        [ home_path, 'Home', 'people' ],
        [ settings_path, 'Settings', 'people' ],
        [ profile_path, 'Profile', 'people' ]
        # change password will go here
      ]
      if current_talk
        @routes += [ control_talk_path(current_talk), "Current Talk", 'talks' ]
      end
      @routes += [
        [ new_talk_path, 'Create Talk', 'talks' ],
        [ my_messages_path, 'My Messages', 'messages' ]
      ]
    else 
      @person = anonymous
      @routes = [
        [ signin_path, 'Sign In', 'sessions' ],
        [ signup_path, 'New Account', 'people' ]
        # email password will go here
      ]
    end
    @person ||= anonymous # in case current_person came back nil

    # logger.debug("StaticPagesController.sitemap: @person: #{@person.inspect}")

    @routes += [
      [ search_people_path, 'Search for People', 'people' ],
      [ search_path, 'Search for Talks', 'talks' ],
      [ helps_path, 'List of Help Pages' , 'helps' ],
      [ static_pages_about_path, 'About' , 'static_pages' ],
      [ static_pages_contact_path, 'Contact' , 'static_pages' ],
      [ static_pages_privacy_path, 'Privacy' , 'static_pages' ],
      [ credits_path, 'Credits' , 'credits' ],
      [ faqs_path, 'Frequently Asked Questions' , 'faqs' ],
      [ static_pages_sitemap_path, 'Site Map', 'static_pages' ]
    ]

    if admin?
      @routes += [
        [ new_credit_path, 'New Credit' , 'credits' ],
        [ new_faq_path, 'New FAQ' , 'faqs' ],
        [ new_help_path, 'New Help' , 'helps' ]
      ]
    end

    # logger.debug("StaticPagesController.sitemap: @routes: #{@routes.inspect}")

  end

end
