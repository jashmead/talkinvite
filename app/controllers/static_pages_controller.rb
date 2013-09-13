class StaticPagesController < ApplicationController
  def about
  end

  def contact
  end

  def credits
  end

  def help
  end

  def menu
  end

  def privacy
  end

  def splash
    @talk = current_person.talks.build if signed_in?
  end
end
