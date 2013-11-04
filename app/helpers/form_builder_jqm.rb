class FormBuilderJqm < ActionView::Helpers::FormBuilder

  def pre_bit(attribute)
    '<div class="fieldcontain field ui-hide-label">' + label(attribute)
  end

  def post_bit
    '</div>'
  end

  def text_field(attribute, options = {} )
    (pre_bit(attribute) + super + post_bit).html_safe
  end

  def text_area(attribute, options = {} )
    (pre_bit(attribute) + super + post_bit).html_safe
  end

end
