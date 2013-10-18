## 1. shared controller code goes here
## 1. for no doubt excellent reason, all functions here end in '_q'
## 1. json code is not currently being exercised
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
  def report_q(klass, rows) 
    if rows.size == 1
      singular = klass.to_s.downcase
      flash.now[:success] = "Found one matching #{singular}."
    else 
      plural = klass.to_s.downcase.pluralize
      flash.now[:success] = "Found #{rows.size.to_s} matching #{plural}."
    end
  end

  def search
  end

  # Search klass for string 'q'.
  # Set flash messages appropriately.
  # Return to search screen on error or no rows found
  # Return the (paginated) rows found on success.
  # Called by 'found'.
  def search_q(klass)

    # explicit renders here keep the default render in the caller from executing
    q = check_q
    if ! q
      flash.now[:alert] = "Please specify something to search for."
      render :search and return
    end

    # build up the query string & the array of parameters
    query_array = []
    param_array = []
    search_fields_array = search_fields

    if search_fields_array.size == 0
      query_array = [ '1 = 1' ] # all rows
    else
      search_fields_array.each do |f|
        query_array.push( f + ' like ? ' )
        param_array.push( "%#{q}%" )
      end
    end

    logger.debug("ApplicationController.search_q: query_array: #{query_array.inspect}, param_array: #{param_array.inspect}")

    @rows = klass.where(query_array.join(' or '), *param_array)

    # don't really need the check on '@rows' being nil, but feels safer somehow
    if ! @rows || @rows.size == 0
      plural = klass.to_s.downcase.pluralize
      flash.now[:alert] = "No matching #{plural} found for '#{q}'.  Please try again."
      render :search and return
    end

    report_q(klass, @rows) 

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
        format.html { redirect_to model, 
          notice: model.class.to_s.downcase + ' was successfully created.' }
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

end
