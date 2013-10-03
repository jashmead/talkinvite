## if we need to fix all the controller, i.e. to add a search or a found method, can do so here
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  include SessionsHelper

  # search klass for string 'q'.
  # Set flash messages appropriately.
  # Return nil on error or no rows found.
  # Return the rows found on success.
  # Used by 'found'.
  def search_q(klass)

    q = params['search']['q']
    q.strip! if q
    if ! q || q == ''
      flash.now[:error] = 'Please specify something to look for.'
      return nil
    end
      
    @rows = klass.search(q)
    if ! @rows || @rows.size == 0
      plural = klass.to_s.downcase.pluralize
      flash.now[:alert] = "No matching #{plural} found for '#{q}'.  Please try again."
      return nil
    end

    if @rows.size == 1
      singular = klass.to_s.downcase
      flash.now[:success] = "Found one matching #{singular}."
    else 
      plural = klass.to_s.downcase.pluralize
      flash.now[:success] = "Found #{@rows.size.to_s} matching #{plural}."
    end

    @rows

  end

end
