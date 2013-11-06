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

# WORKAROUND:  partials appear to have access to all functions available to forms
#   -- therefore put code needing the application helpers, the controller object, & so on 
#   -- in 'app/views/shared'
 
class FormBuilderJqm < ActionView::Helpers::FormBuilder

  def pre_field(attribute)
    '<div class="fieldcontain field ui-hide-label">' + label(attribute)
  end

  def post_field
    '</div>'
  end

  def check_box(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
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

  def hidden_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def number_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def password_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def phone_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def radio_button(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def range_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def esarch_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
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

  def submit
    super 'data-inline' => true
  end

end
