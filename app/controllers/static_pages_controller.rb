# what is philosophy on 'store_location'? 
#   -- for now, since sitemap is an entry point, include it there
#   -- note that sitemap currently only exposed to admins
#   -- other actions here are leaf nodes, leave alone
class StaticPagesController < ApplicationController

  # dummy out the search_fields; should never be searching this any way
  def search_fields
    []
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def sitemap
    # we read the action off the path, and the controller too if it is not explicitly given as the third element
    store_location
    @routes = []
    if signed_in?
      @routes += [
        [ home_path, 'Home', 'people' ],
        [ profile_path, 'Profile', 'people' ],
        [ settings_path, 'Settings', 'people' ],
        [ upgrade_people_path, 'Upgrade', 'people' ]
      ]
    else 
      @routes += [
        [ signin_path, 'Sign In', 'sessions' ],
        [ signup_path, 'Create New Account (Sign Up)', 'people' ]
      ]
    end
    @routes += [
      [ search_people_path, 'Search for People', 'people' ],
      [ people_path, 'List of People', 'people' ],

      [ search_talks_path, 'Search for Talks', 'talks' ],
      [ active_talks_path, 'Active Talks', 'talks' ],
      [ talks_path, 'List Talks', 'talks' ],
    ]
    if signed_in?
      @routes += [
        [ my_talks_path, 'My Talks', 'talks' ],
        [ new_talk_path, 'New Talk', 'talks' ]
      ]
    end
    # maps should only show if there is a current talk
    @routes += [
      [ maps_path, 'Maps', 'maps' ],
      [ new_map_path, 'New Map', 'maps' ],
    ]

    @routes.push( [ help_path, 'Help' , 'static_pages' ] )
    # @routes.push([ new_help_path, 'New Help' , 'static_pages' ]) if admin?
    @routes.push( [ credits_path, 'Credits' , 'static_pages' ] )
    @routes.push([ new_credit_path, 'New Credit' , 'static_pages' ]) if admin?
    @routes.push( [ faqs_path, 'FAQs' , 'static_pages' ] ) 
    @routes.push([ new_faq_path, 'New FAQ' , 'static_pages' ]) if admin?

    @routes += [
      [ static_pages_about_path, 'About' , 'static_pages' ],
      [ static_pages_contact_path, 'Contact' , 'static_pages' ],
      [ static_pages_privacy_path, 'Privacy' , 'static_pages' ],
      [ static_pages_sitemap_path, 'Site Map', 'static_pages' ]
    ]
  end

end
