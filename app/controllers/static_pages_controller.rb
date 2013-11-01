class StaticPagesController < ApplicationController

  #TBD:  sitemap

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
    @routes = []
    logger.debug("CC: StaticPagesController.sitemap: @routes: #{@routes}")
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
    logger.debug("CC: StaticPagesController.sitemap: @routes: #{@routes}")
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
    logger.debug("CC: StaticPagesController.sitemap: @routes: #{@routes}")
    @routes += [
      [ maps_path, 'Maps', 'maps' ],
      [ new_map_path, 'New Map', 'maps' ],

      [ help_path, 'Help' , 'static_pages' ],
      [ credits_path, 'Credits' , 'static_pages' ],
      [ faqs_path, 'FAQs' , 'static_pages' ]
    ]
    if admin?
      @routes.push([ new_faq_path, 'New FAQ' , 'static_pages' ])
    end
    logger.debug("CC: StaticPagesController.sitemap: @routes: #{@routes}")
    @routes += [
      [ static_pages_about_path, 'About' , 'static_pages' ],
      [ static_pages_contact_path, 'Contact' , 'static_pages' ],
      [ static_pages_privacy_path, 'Privacy' , 'static_pages' ],
      [ static_pages_sitemap_path, 'Site Map', 'static_pages' ]
    ]
    logger.debug("CC: StaticPagesController.sitemap: @routes: #{@routes}")
  end

end
