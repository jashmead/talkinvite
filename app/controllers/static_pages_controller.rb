# what is philosophy on 'store_location'? 
#   -- for now, since sitemap is an entry point, include it there
#   -- note that sitemap currently only exposed to admins
#   -- other actions here are leaf nodes, leave alone
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

  # codeclimate finds 'sitemap' too complex; 
  #   could clean up by making routes an array with flags
  #   perhaps best as a set of hashes, with one hash being the 'signed_in', 'not_signed_in', 'common', 'admin' flag
  #   clean enuf for now, in any case
  # note:  spec for sitemap serves as a quick test of all the entry-point forms, at least they turn on
  # TBD:  where should the sitemap itself be located? should it be accessible to users in general?
  def sitemap
    # we read the action off the path, and the controller too if it is not explicitly given as the third element
    store_location

    if signed_in?
      @person = current_person
      @routes = [
        [ home_path, 'Home', 'people' ],
        [ settings_path, 'Settings', 'people' ],
        [ profile_path, 'Profile', 'people' ],
        [ my_talks_person_talks_path(@person), 'My Talks', 'talks' ],
        [ new_person_talk_path(@person), 'Create Talk', 'talks' ],
        [ my_messages_path, 'My Messages', 'messages' ]
      ]
    else 
      @person = anonymous
      @routes = [
        [ signin_path, 'Sign In', 'sessions' ],
        [ signup_path, 'New Account', 'people' ]
      ]
    end
    @person ||= anonymous # in case current_person came back nil

    logger.debug("StaticPagesController.sitemap: @person: #{@person.inspect}")

    if admin?
      @routes += [
        [ new_credit_path, 'New Credit' , 'credits' ],
        [ new_faq_path, 'New FAQ' , 'faqs' ],
        [ new_help_path, 'New Help' , 'helps' ]
      ]
    end

=begin
    if current_talk 
      # and fold in comments & so on as well
      @routes += [
        [ maps_path, 'Maps', 'maps' ],
        [ new_map_path, 'New Map', 'maps' ]
      ]
    end
=end

    # TBD we had to shift from active_path to active_person_talks_path  (& then to posted_person_talks_path)
    #   -- and from talks_path to person_talks_path
    #   -- why?
    @routes += [
      [ people_path, 'List of People', 'people' ],
      [ search_people_path, 'Search for People', 'people' ],
      [ search_path, 'Search for Talks', 'talks' ],
      [ posted_person_talks_path(@person), 'Current Talks', 'talks' ],
      [ person_talks_path(@person), 'List of Talks', 'talks' ],   # try going with only search, no list
      [ credits_path, 'Credits' , 'credits' ],
      [ faqs_path, 'Frequently Asked Questions' , 'faqs' ],
      [ helps_path, 'Help' , 'helps' ],
      [ static_pages_about_path, 'About' , 'static_pages' ],
      [ static_pages_contact_path, 'Contact' , 'static_pages' ],
      [ static_pages_privacy_path, 'Privacy' , 'static_pages' ],
      [ static_pages_sitemap_path, 'Site Map', 'static_pages' ]
    ]
    logger.debug("StaticPagesController.sitemap: @routes: #{@routes.inspect}")

  end

end
