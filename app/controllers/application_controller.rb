## if we need to fix all the controller, i.e. to add a search or a found method, can do so here
class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  # pull out the query string & make sure it is not empty
  def check_q
    q = params['search']['q']
    q.strip! if q
    if ! q || q == ''
      flash.now[:error] = 'Please specify something to look for.'
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

  # Search klass for string 'q'.
  # Set flash messages appropriately.
  # Return to search screen on error or no rows found
  # Return the (paginated) rows found on success.
  # Called by 'found'.
  def search_q(klass)

    # explicit renders here keep the default render in the caller from executing
    q = check_q
    if ! q
      render :search and return
    end

    @rows = klass.search(q)
    # don't really need the check on '@rows' being nil, but feels safer somehow
    if ! @rows || @rows.size == 0
      plural = klass.to_s.downcase.pluralize
      flash.now[:alert] = "No matching #{plural} found for '#{q}'.  Please try again."
      render :search and return
    end

    report_q(klass, @rows) 

    @rows.paginate(page: params[:page])
  end

end
