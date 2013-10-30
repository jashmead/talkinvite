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

end
