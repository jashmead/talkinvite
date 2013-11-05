## 1. shared controller code goes here
## 1. for no doubt excellent reason, all functions here end in '_q'
## 1. json code is not currently being exercised
## 1. in some sense, ApplicationController is the center of the application
## 1. to get at the functions in app/helpers, use view_context, i.e. view_context.current_layout
## 1. search_q & report_q currently (10/28/13) flagged as overcomplex by codeclimate

## for associations we have 
#     assocation, 
#     association=, 
#     build_association (in memory only), 
#     create_association (in memory & on disk)
##  use association to fetch, build + = to create in memory, create to build & save at the same time
##  -- does 'update' on parent automagically save the children?  can check the logs to see, or check the ActiveRecord docs

## have defined fetch_children for people, talks, & venues, and fetch_parents for talks
#   -- could define similar for the rest of the tables; wait till we see what is needed in practice for them

class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # this is how we get signed_in? and its friends:
  # include only applies to modules; looks at app/helpers for files (& other places?)
  include SessionsHelper

  # default search fields: currently only the big three (talks, people, venues) use searches
  def search_fields 
    [ 'name', 'description' ]
  end

  # footer_fields often changed by controllers
  # only six controllers need footer_fields:  people, talks, venues, faqs, credits, & ads

  def foot_left
    if signed_in?
      { 'controller_name' => 'people', 'label' => 'Home', 'action' => 'home' }
    else
      { 'controller_name' => 'talks', 'label' => 'Active', 'action' => 'active' }
    end
  end

  def foot_right
    if admin?
      { 'controller_name' => 'static_pages', 'label' => 'Site Map', 'action' => 'sitemap' }
    else
      { 'controller_name' => 'helps', 'label' => 'Help', 'action' => 'index' }  # TBD: switch index to search
    end
  end

  # center feet are what changes controller to controller
  def feet_center 
    [ '/static_pages/about', '/static_pages/contact', '/static_pages/privacy' ]
  end

  def footer_fields 
    logger.debug("ApplicationController.footer_fields: admin: #{admin?}, signed_in?: #{signed_in?}")
    # currently, routes for nav buttons don't have parameters in them...
    # note that root_path (used in logo) and start are the same thing
    [ foot_left ] + feet_center + [ foot_right ]
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
    logger.debug("CC: ApplicationController.report_q: flash.now: #{flash.now.inspect}")
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
  # Set flash messages appropriately.
  # Return to search screen on error or no rows found
  # Return the (paginated) rows found on success.
  # Called by 'found'.
  # search_q spotted as complex by codeclimate 10/29/13, complexity 31 (was 39, but cleaned up)
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
    @rows = klass.where(query_array.join(' or '), *query_array.map { |f| q_like } )

    report_q(klass, @rows, q) 

    if @rows.size == 0
      render :search and return
    end

    @rows.paginate(page: params[:page])
  end

  # suppress codeclimate duplication warning
  def fail_q(model, format, next_action)
      format.html { render action: next_action }
      format.json { render json: model.errors, status: :unprocessable_entity }
  end

  # we may be able to read the klass off the model, a bit more DRY
  def create_q(model)
    respond_to do |format|
      if model.save
        format.html { 
          redirect_back_or root_url
          flash.now[:success] = model.class.to_s.downcase + ' was successfully created.'
        }
        # TBD: on format.json, do we want action: 'show' or do we want 'index'?  what does 'location: model' mean?
        format.json { render action: 'show', status: :created, location: model }
      else
        fail_q(model, format, 'new')
      end
    end
  end

  # we may be able to read the klass off the model, a bit more DRY
  def update_q(model, params)
    respond_to do |format|
      if model.update(params)
        format.html { 
          # TBD:  is root_path right as the default?
          redirect_back_or root_url
          flash.now[:success] = model.class.to_s.downcase + ' was successfully updated.' }
        format.json { head :no_content }
      else
        fail_q(model, format, 'edit')
      end
    end
  end

  def destroy_q(model, url) 
    model.destroy
    respond_to do |format|
      format.html { redirect_to url }
      format.json { head :no_content }
    end
  end

  def map_q(model, params)
  end

  protected
    ## only controllers can call a teapot
    ## teapot_q is our:  we haven't built that quite yet page
    def teapot_q

      # 518 is the HTTP teapot error, as in "I'm steamed because I'm a teapot"

      # 'layout: false': if we don't turn off the layout, the page looks really weird
      #   which may help with understanding how the layouts work...
    
      # TBD: with the shift to jQueryMobile, we can revisit the layout question

      render 'static_pages/518', layout: false
    end

end
