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
      layout
    else
      File.basename(layout.identifier).split('.').first 
    end
  end

=begin
  # TBD:  does 'button_back' actually work? needed? (given we are using stuff in the header)
  def button_back (tag) 
    link_to tag, :back, 'data-inline' => true, 'data-role' => 'button', 'data-mini' => true
  end
=end

  # TBD:  add a warning color to the delete button, here or better via css
  # TBD: DRY the buttons out a bit, lots of common options
  def button_delete (model) 
    tag = model.class.to_s.downcase
    link_to 'Delete', model, method: :delete, title: "Delete this #{tag}",
      data: { confirm: "Are you sure you want to delete this #{tag}" },
      'data-inline' => true, 'data-role' => 'button' , 'data-icon' => 'delete', 'data-mini' => true
  end

  # can probably get path from model (perhaps even tag), but no create need
  def button_create (tag, path, options = {})
    defaults = { :method => :get, 'data-inline' => true, 'data-role' => 'button' , 'data-icon' => 'plus', 'data-mini' => true } 
    options.merge! defaults
    link_to tag, path, options
  end

  # TBD:  various front ends to button_inline possible, as for 'new', 'update', and so on...
  def button_inline (tag, link_path, options = {}) 
    options['data-role'] ||= 'button'
    options['data-inline'] ||= true
    options['data-mini'] ||= true
    link_to tag, link_path, options
  end

  # returns correct data-theme (based on controller) as a single letter where the letter can be from a to f, depending on the context
  # a = black & white, b = blue, c = red, d = green, e = cyan, f = orange
  def swatch ( controller_name = nil ) 
    # TBD:  go back to colors or get a better theme
    return 'a'  # debugging aid, 'a' is easiest to read, black on white
    if ! controller_name 
      controller_name = controller.controller_name
    end
    # logger.debug("swatch(#{controller_name})")
    theme_letter = case controller_name
      when 'talks', 'services'
        'b' # blue  -- likely to be graphite's water
      when 'people', 'members'
        'c' # red   -- likely to be graphite's royal
      when 'messages', 'comments', 'posts'
        'e' # cyan  -- likely to be graphite's mint
      when 'helps'
        'f' # orange -- warm & friendly, we hope!
      when 'maps'
        'd' # green, in anticipation of the revival of venues, locations?
      # using black & white for the non-working parts of the system
      when 'static_pages', 'credits'
        'a' # dull stuff so black & white
      when 'sessions'   # sign in & sign out seem to look better in black/white rather than red
        'a' # dull stuff so black & white
      else
        'a' # black and white
    end
  end

  # data_theme is wrapper for letter chosen by swatch
  def data_theme( controller_name = nil ) 
    return " data-theme=\"#{swatch( controller_name )}\" ".html_safe
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

  # TBD:  find a cleaner way to do this
  #   -- from http://api.rubyonrails.org/classes/ActionView/Helpers/TextHelper.html#method-i-pluralize
  #   -- function needed inside controllers, so copied here
  #   -- can we use the setting that gives access to view stuff to apps?
=begin
  def pluralize(count, singular, plural = nil)
    word = if (count == 1 || count =~ /^1(\.0+)?$/)
      singular
    else
      plural || singular.pluralize
    end

    "#{count || 0} #{word}"
  end
=end

end
