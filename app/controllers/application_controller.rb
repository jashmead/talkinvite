## 1. shared controller code goes here
## 1. for no doubt excellent reason, all functions here end in '_q'
## 1. json code is not currently being exercised
## 1. in some sense, ApplicationController is the center of the application
## 1. to get at the functions in app/helpers, use view_context, i.e. view_context.current_layout

class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  # default search fields
  def search_fields 
    [ 'name', 'description' ]
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
    if rows.size == 0
      plural = klass.to_s.downcase.pluralize
      flash.now[:alert] = "No matching #{plural} found for '#{q}'.  Please try again."
    elsif rows.size == 1
      singular = klass.to_s.downcase
      flash.now[:success] = "Found one matching #{singular}."
    else 
      plural = klass.to_s.downcase.pluralize
      flash.now[:success] = "Found #{rows.size.to_s} matching #{plural}."
    end
  end

  def found
    teapot_q
  end

  # basic searches for talks, people, venues
  def my_friends
    teapot_q
  end

  def my_tags
    teapot_q
  end

  def my_talks
    teapot_q
  end

  def nearby
    teapot_q
  end

  def recent
    teapot_q
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
  # codeclimate currently assigns complexity 39
  # eliminated intermediate steps, see what happens
  def search_q(klass)

    # explicit renders here keep the default render in the caller from executing
    q = check_q
    if ! q
      flash.now[:alert] = "Please specify something to search for."
      render :search and return
    end

    # build up the query string & the array of parameters
    if search_fields().size == 0
      # note the implicit limit will keep this from returning all the rows
      @rows = klass.all
    else
      q_like = '%' + q + '%'
      query_array = search_fields().map { |f| f + ' like ? ' }
      @rows = klass.where(query_array.join(' or '), *query_array.map { |f| q_like } )
    end

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
          redirect_to model, 
          notice: model.class.to_s.downcase + ' was successfully created.'
        }
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
        format.html { redirect_to model, 
          notice: model.class.to_s.downcase + ' was successfully updated.' }
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

  protected
    ## only controllers can call a teapot
    def teapot_q

      # 518 is the HTTP teapot error, as in "I'm steamed because I'm a teapot"

      # 'layout: false': if we don't turn off the layout, the page looks really weird
      #   which may help with understanding how the layouts work...

      render 'static_pages/518', layout: false
    end

end
