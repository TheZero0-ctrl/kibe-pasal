# frozen_string_literal: true

ActionView::Base.field_error_proc = lambda { |html_tag, instance|
  if /^<label/.match?(html_tag)
    html_tag
  else
    html = Nokogiri::HTML::DocumentFragment.parse(html_tag)
    html.children.add_class('error-input')
    error_message_markup = <<~HTML
      <p class='error-text'>
      #{sanitize(instance.error_message.to_sentence)} </p>
    HTML

    "#{html}#{error_message_markup}".html_safe
  end
}
