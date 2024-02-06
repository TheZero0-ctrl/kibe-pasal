# frozen_string_literal: true

module SvgHelper
  def svg(svg_name, **attributes)
    svg_markup =
      render file:
        Rails.root.join("app/views/shared/svg/#{svg_name}.svg").to_s

    xml = Nokogiri::XML(svg_markup)
    attributes&.each do |key, value|
      xml.root.set_attribute(key, value)
    end

    xml.root.to_xml.html_safe
  end
end
