class StaticPagesController < ApplicationController

  def search_fields
    []
  end

  def about
  end

  def contact
  end

  def help
    @helps = Faq.where("question like '%How%'")
    logger.debug("CC: StaticPagesController.help: @helps: #{@helps.inspect}") 
  end

  def privacy
  end

end
