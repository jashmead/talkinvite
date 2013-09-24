class StaticPagesController < ApplicationController
  def about
  end

  def contact
  end

  def credits
  end

  def help
  end

  def home
    if signed_in?
      @talk = current_person.talks.build if signed_in?
      @feed_talks = current_person.feed.paginate(page: params[:page])
    end
  end

  def menu
  end

  def privacy
  end

  def splash

  end
end
