# appears code here is accessible from inside a form, but not from inside a controller
# to get at code from inside a controller use the view_context, i.e. to call current_layout use view_context.current_layout
module ApplicationHelper

  ## see http://stackoverflow.com/questions/3326579/rails3-get-current-layout-name-inside-view
  def current_layout
    # call interior function controller._layout
    layout = controller.send(:_layout)
    if layout.instance_of? String
      # logger.debug("ApplicationHelper.current_layout(1): #{layout.inspect}")
      layout
    else
      ## layout.identifier = /Volumes/Isis/talkinvite/talkinvite/app/views/layouts/application.html.erb
      logger.debug("ApplicationHelper.layout: #{layout.inspect}")

      ## this gives "application" if that is the first layout, but will give, say, 'credits' if that is the top layout
      File.basename(layout.identifier).split('.').first 
    end
  end

  # TBD:  add in the 'back' button to the mobile init pages
  def button_back (back_path) 
    button_inline('Back', back_path)
  end

  # TBD:  add a warning color to the delete button, here or better via css
  def button_delete (model) 
    link_to 'Delete', model, method: :delete, data: { confirm: 'Are you sure?' }, 
      'data-inline' => true, 'data-role' => 'button' 
  end

  def button_inline (tag, new_path) 
    link_to tag, new_path, 'data-role' => 'button', 'data-inline' => true
  end

  # returns a correct data-theme="l" where l can be from a to f, depending on the context
  def swatch ( controller_name = nil ) 
    if ! controller_name 
      controller_name = controller.controller_name
    end
    theme_letter = case controller_name
      when 'talks'
        'b' # blue  -- likely to be graphite's water
      when 'people', 'members', 'relationships'
        'c' # red   -- likely to be graphite's royal
      when 'venues'
        'd' # green -- none of the graphite themes look that much better
      when 'tags', 'messages', 'comments', 'notifications', 'socials'
        'e' # cyan  -- likely to be graphite's mint
      when 'credits', 'faqs', 'static_pages', 'ads'
        'f' # orange -- likely to be yellow or ochre or graphite's sand
      when 'attachments', 'calendars', 'maps'
        'a' # or go for white on black? inverse of 'a'?
      else
        'a' # black and white
    end
    return " data-theme=\"#{theme_letter}\" ".html_safe
  end

end
