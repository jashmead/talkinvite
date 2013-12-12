# Application Controller

## 1. shared controller code goes here
## 1. for no doubt excellent reason, all functions here end in '_q'
## 1. json code is not currently being exercised
## 1. in some sense, ApplicationController is the center of the application
## 1. to get at the functions in app/helpers, use view_context, i.e. view_context.current_layout
## 1. search_q & report_q currently (10/28/13) flagged as overcomplex by codeclimate

=begin
for associations

use association to fetch, build + = to create in memory, create to build & save at the same time
  TBD:  does 'update' on parent automagically save the children?  can check the logs to see, or check the ActiveRecord docs

going from child to parent (talk to person) we have:

  assocation, 
  association=, 
  build_association (in memory only), 
  create_association (in memory & on disk)

  example:  @talk.person, @talk.person=, @talk.build_person, @talk.create_person

going from parent to child (talk to posts, members) we have:

  children(force_reload = false)
  children<<(object, ...)
  children.delete(object, ...)
  children.destroy(object, ...)
  children=objects
  child_ids
  child_ids=ids
  children.clear
  children.empty?
  children.size
  children.find(...)
  children.where(...)
  children.exists?(...)
  children.build(attributes = {}, ...)
  children.create(attributes = {})

  @talk.posts, @talk.posts<<(post, ...), @talk.posts.delete(post,...), @talk.posts.destroy(post,...),
    @talk.posts = posts, @talk.post_ids, @talk.post_ids = ids, @talk.posts.clear, @talk.posts.empty?,
    @talk.posts.size, @talk.posts.find(post_id,...), @talk.posts.where(post where condition),
    @talk.posts.exists? (check for posts?), @talk.posts.build(attributes = {}, ...), 
    @talk.create(attributes = {}, ...)

=end

## have defined fetch_children for people and talks and fetch_parents for talks
#   -- could define similar for the rest of the tables; wait till we see what is needed in practice for them

class ApplicationController < ActionController::Base

  MAX_ITEMS_PER_PAGE = 10

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  # this is how we get person_signed_in? and its friends:
  # include only applies to modules; looks at app/helpers for files (& other places?)
  include SessionsHelper

  # default search fields: currently only the big two (talks, people) use searches
  def search_fields 
    [ 'name', 'description' ]
  end

  # footer_fields often changed by controllers
  # only some controllers need footer_fields:  people, talks, credits, helps

  def feet_for_help_pages 
    [ helps_path, credits_path, about_path ]
  end

  # TBD:  shift to a model where the new talk page will let you sign_in/create a new account on the fly...
  def feet_for_people_pages
    if person_signed_in?
      [ talks_new_page, talks_search_page, sign_out_page ]
    else
      [ sign_in_page, talks_search_page, about_path ]
    end
  end

  def feet_for_static_pages
    [ static_pages_about_path, static_pages_contact_path, static_pages_privacy_path ]
  end

  # center feet are what changes controller to controller; override this to change
  def feet_center 
    feet_for_static_pages
  end

  # note:  accommodating current_help_page is much of the reason for the generality of the footer
  def current_help_page 
    # logger.debug("ApplicationController.current_help_page: #{self.controller_name}_#{self.action_name} self: #{self.inspect}")
    return [ 
      'label' => 'Help', 
      'action_name' => 'help', 
      'controller_name' => 'helps', 
      # note: variable 'controller' not available here, 
      #   --  but we *are* the controller so call the controller_name & action_name methods on self
      'href' => '/helps/' + self.controller_name + '_' + self.action_name
    ]
  end

  def home_page
    { 'action_name' => 'home', 'controller_name' => 'people', 'label' => 'Home', 'href' => home_url }
  end

  def sign_in_page
    logger.debug("ApplicationController.sign_in_page: href: " + new_person_session_url)
    { 'action_name' => 'sign_in', 
      'controller_name' => 'devise/sessions', 
      'label' => 'Sign In', 
      'href' => new_person_session_url } 
  end

  def sign_out_page
    logger.debug("ApplicationController.sign_out_page: href: " + destroy_person_session_url)
    { 'action_name' => 'sign_out', 
      'controller_name' => 'devise/sessions', 
      'label' => 'Sign Out', 
      'href' => destroy_person_session_url }
  end

  def sign_up_page
    logger.debug("ApplicationController.sign_up_page: href: " + new_person_registration_url)
    { 'action_name' => 'sign_up', 
      'controller_name' => 'devise/registrations', 
      'label' => 'Sign Up', 
      'href' => new_person_registration_url }
  end

  def sitemap_page
    { 'action_name' => 'sitemap', 'controller_name' => 'static_pages', 'label' => 'Site Map', 'url' => sitemap_path } 
  end

  # TBD:  switch to a real start page when we have one built!, see notes for talks#start
  def start_page
    { 'action_name' => 'start', 'controller_name' => 'talks', 'label' => 'Start', 'url' => start_path } 
  end

  def talks_new_page
    { 'action_name' => 'new',
      'controller_name' => 'talks',
      'label' => 'New Talk', # since icon will carry the action
      'url' => new_talk_path
    }
  end

  def talks_search_page
    { 'action_name' => 'search',
      'controller_name' => 'talks',
      'label' => 'Talks',  # since icon will carry the action
      'href' => search_talks_url
    } 
  end

  # actual interpretation of each foot is done in views/layouts/_footer.html.erb
  # TBD:  let footer_fields pass an id thru to _footer, to allow for persistent footers
  def footer_fields

    # currently have three tabs specific to controller, plus wings specific to login status
    
    # put home (or sitemap) or active talks on the left
    feet = [ person_signed_in? ? ( self.action_name === 'home' ? sitemap_page : home_page ) : start_page ]

    # core of the tabs:
    feet += feet_center

    # put sitemap or help on the right
    feet += current_help_page 

  end

  # pull out the query string & make sure it is not empty
  # if running a search/start screen, start will need to run check_q as well
  def check_q
    q = params['search']['q']
    q.strip! if q
    if ! q || q == ''
      # flash.now[:error] = 'Please specify something to look for.'
      return nil
    end
    return q
  end
      
  # report success
  def report_q(klass, rows, q) 
    count = rows.size
    singular = klass.to_s.downcase
    case count
      when 0
        flash.now[:alert] = "No matching #{singular.pluralize} found for '#{q}'.  Please try again."
      when 1
        flash.now[:success] = "Found one matching #{singular}."
      else 
        flash.now[:success] = "Found #{count.to_s} matching #{singular.pluralize}."
    end
  end

  def found
    teapot_q
  end

  # common code for index methods
  def index
    store_location
  end

  def search
    # placeholder; individual controllers should redefine this when their searches are built
    teapot_q
  end

  # Search klass for string 'q'.
  # -- Set flash messages appropriately.
  # -- Return to search screen on error or no rows found
  # -- Return the (paginated) rows found on success.
  # -- Called by 'found'.
  # -- search_q spotted as complex by codeclimate 10/29/13, complexity 31 (was 39, but cleaned up)
  # TBD:  refactor so we can run the search on a per Model basis
  def search_q(klass)

    # explicit renders here keep the default render in the caller from executing
    q = check_q
    if ! q
      flash.now[:alert] = "Please specify something to search for."
      render :search and return
    end

    # build up the query string & the array of parameters
    # if search_fields returns no fields (why is it being called?) then the where clause will be empty & get all rows

    q_like = '%' + q + '%'
    query_array = search_fields().map { |f| f + ' like ? ' }
    # TBD:  fold in includes per Model
    @rows = klass.where(query_array.join(' or '), *query_array.map { |f| q_like } )

    report_q(klass, @rows, q) 

    if @rows.size == 0
      render :search and return
    end

    # will_paginate: https://github.com/mislav/will_paginate
    # @rows.paginate(page: params[:page], per_page: 10)
    @rows # put in pagination later, see jquery_mobile_paginate_link_renderer.rb
  end

  # suppress codeclimate duplication warning
  def fail_q(model, format, next_action)
      format.html { render action: next_action }
      format.json { render json: model.errors, status: :unprocessable_entity }
  end

  def create_q(model)
    respond_to do |format|
      # TBD: rescue needed here?
      if model.save
        format.html { 
          # we should have stored the previous location in session
          # TBD: build a default edit path or force controller & action?
          redirect_back_or root_url
          flash.now[:success] = model.class.to_s.downcase + ' was successfully created.'
        }
        # TBD: on format.json, do we want action 'show' or 'edit' or 'index'?  what does 'location: model' mean?
        format.json { render action: 'show', status: :created, location: model }
      else
        fail_q(model, format, 'new')
      end
    end
  end

  def update_q(model, params)
    respond_to do |format|
      # TBD: rescue needed here?
      if model.update(params)
        logger.debug("ApplicationController.update_q: model: #{model.inspect}")
        format.html { 
          # TBD:  is root_path right as the default?, if not, pass along a url, a la destroy_q
          redirect_back_or root_url
          flash.now[:success] = model.class.to_s.downcase + ' was successfully updated.' }
        format.json { head :no_content }
      else
        fail_q(model, format, 'edit')
      end
    end
  end

  # note:  ':back' not a good choice for url since usually the source page will have been rendered irrelevant by the destroy
  def destroy_q(model, url)
    store_location
    begin
      model.destroy
    rescue
      flash.now[:error] = "We were unable to delete the " + model.class.to_s.downcase + ", sorry about that!"
      # TBD:  add in a json response, if necessary
      redirect_back_or url
    end
    respond_to do |format|
      format.html { redirect_to url }
      format.json { head :no_content }
    end
  end

  def map_q(model, params)
  end

  def calendar_q(model, params)
  end

  protected
    # only controllers can call a teapot
    #   -- teapot_q is internal:  is the 'under-construction' error
    #   -- 518 is the HTTP teapot error, as in "I'm steamed because I'm a teapot"
    def teapot_q
      # TBD: 'layout: false': if we don't turn off the layout, the page looks really weird, why?
      render 'static_pages/518', layout: false
    end

    # devise version of strong parameters
    # note: only three (devise) actions require parameters from the scary internet
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u| 
        u.permit :name, :email, :password, :password_confirmation
      end
      devise_parameter_sanitizer.for(:sign_in) do |u| 
        u.permit :email, :password, :password_confirmation
      end
      devise_parameter_sanitizer.for(:account_update) do |u| 
        u.permit :name, :email, :description, :password, :password_confirmation, :current_password
      end
    end
end
