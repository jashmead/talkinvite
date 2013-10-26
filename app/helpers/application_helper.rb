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

  def button_inline (tag, new_path) 
    link_to tag, new_path, 'data-role' => 'button', 'data-inline' => true
  end

  def button_back (back_path) 
    button_inline('Back', back_path)
  end

  # TBD:  add a warning color to the delete button, here or better via css
  def button_delete (model) 
    link_to 'Delete', model, method: :delete, data: { confirm: 'Are you sure?' }, 
      'data-inline' => true, 'data-role' => 'button' 
  end

end
