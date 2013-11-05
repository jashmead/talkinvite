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

  def text_field(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def text_area(attribute, options = {} )
    (pre_field(attribute) + super + post_field).html_safe
  end

  def submit
    super 'data-inline' => true
  end

end
