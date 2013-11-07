# accessibility of tools here not entirely clear

#   code here is accessible from inside a form, 
#     -- but not from inside a controller 
#       -- or from inside 'form_for'?

#   to get at this code from inside a controller
#     -- use the view_context, 
#     -- i.e. to call current_layout use view_context.current_layout

#   put view helpers as test_flow & form_for_jqm here
#     -- can store classes in app/helpers as well, i.e. FormBuilderJqm
#     -- looks as if the module_helper files may only be called from within their specific 'view set'

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
      ## logger.debug("ApplicationHelper.layout: #{layout.inspect}")

      ## this gives "application" if that is the first layout, but will give, say, 'credits' if that is the top layout
      File.basename(layout.identifier).split('.').first 
    end
  end

  def button_back (back_path) 
    button_inline('Back', back_path)
  end

  # TBD:  add a warning color to the delete button, here or better via css
  def button_delete (model) 
    link_to 'Delete', model, method: :delete, data: { confirm: "Are you sure you want to delete this #{model.class.to_s.downcase}?" }, 
      'data-inline' => true, 'data-role' => 'button' 
  end

  def button_inline (tag, link_path) 
    link_to tag, link_path, 'data-role' => 'button', 'data-inline' => true
  end

  # returns a correct data-theme="l" where l can be from a to f, depending on the context
  def swatch ( controller_name = nil ) 
    if ! controller_name 
      controller_name = controller.controller_name
    end
    theme_letter = case controller_name
      when 'talks', 'services'
        'b' # blue  -- likely to be graphite's water
      when 'people', 'members', 'sessions'
        'c' # red   -- likely to be graphite's royal
      when 'messages', 'comments', 'posts'
        'e' # cyan  -- likely to be graphite's mint
      when 'faqs', 'static_pages', 'credits'
        'f' # orange -- likely to be yellow or ochre or graphite's sand
      when 'maps'
        'd' # green, in anticipation of the revival of venues, locations?
      when 'helps'
        'a' # black & white
      else
        'a' # black and white
    end
    return " data-theme=\"#{theme_letter}\" ".html_safe
  end

  # test_flow used to figure out where stuff needs to live so we can get at it
  def test_flow(tag)
    logger.info("layouts/_functions.test_flow: #{tag}")
  end

  # from http://api.rubyonrails.org, form_for documentation:
  def form_for_jqm(model, *args, &block)
    options = args.extract_options!
    form_for(model, *(args << options.merge(builder: FormBuilderJqm)), &block)
  end 

  # TBD:  see if we can use content_for or div_for where we are using this
  #   -- noting that jQuery Mobile needs unique ids across the *set* of all pages!
  def tagged_id(tag = nil)
    id_bits = [ controller.controller_name, controller.action_name]
    id_bits.push(tag) if tag
    id_bits.join('-').html_safe
  end

end
