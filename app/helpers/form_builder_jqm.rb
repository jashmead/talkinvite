# FormBuilderJqm automagically picked if we specify the "builder" option to form_for:
#   <%= form_for(@faq, builder: FormBuilderJqm) do |f| %> 
#   -- apparently the search path includes app/helpers & maps back & forth automatically between form_builder_jqm & FormBuilderJqm

# To automate the calling of form_for, 
#   'layouts/_functions' defines form_for_jqm which does a form_for(..., :builder => FormBuilderJqm)
#   -- so the forms should call form_for_jqm, not form_for, and then they get all the wrappers below

# HOWEVER, many support functions are not available here
#   -- logger
#   -- functions defined in application_helpers.rb (ApplicationHelpers)
#   -- link_to
#   -- you can't just go <%=...%>, you have to surround in ''

# WORKAROUND:  
#   -- (shared?) partials appear to have access to all functions available to forms
#     -- therefore put code needing the application helpers, the controller object, & so on 
#     -- in 'app/views/shared'
#
# NOTE:  check ActionView::Helpers::FormBuilder for correct documentation
 
class FormBuilderJqm < ActionView::Helpers::FormBuilder

# note:  naive wrapping of ror buttons doesn't work well with jqm; suspect jqm's button magic
=begin
  def button(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end
=end

  def check_box(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  # note:  collection_radio_buttons currently producing weird stuff
  #   -- hard to figure out what the name is going to be
  def collection_radio_buttons(method, collection, value_method, text_method, options = {}, html_options = {})
    ('<div data-role="fieldcontain"><fieldset data-role="controlgroup" data-type="horizontal">' + super + '</fieldset></div>').html_safe
  end

  def color_local_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def date_local_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def datetime_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def datetime_local_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def email_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def file_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

# if we wrap the hidden field, the label will show, so let hidden fields pass thru to form_for
=begin
  def hidden_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end
=end

  def number_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def password_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def phone_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  # note:  basic radio button has signature:  radio_button(object_name (of actual object), method_name, tag_value, options)
  #   -- but no way to specify the contents of the input
  #   -- collection_radio_buttons gives you a way to specify the content, 
  #     -- but has weird value for name,
  #     -- and doesn't let you put in labels,
=begin
  def radio_button(object_name, method_name, tag_value = nil, options = {})
    (pre_field(method_name) + super + post_field).html_safe
  end
=end

  def range_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def search_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def submit(value = '', options = {})
    options['data-role'] = 'button'
    options['data-inline'] = 'true'
    options['data-mini'] = 'true'
    super value, options
  end

  def telephone_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def text_area(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def text_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def time_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def url_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def week_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end


  private
    def pre_field(attribute)
      '<div class="fieldcontain field ui-hide-label">' + label(attribute, attribute.to_s.titleize)
    end

    def post_field
      '</div>'
    end

end
