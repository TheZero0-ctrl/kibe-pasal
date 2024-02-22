# frozen_string_literal: true

module Address::PermittedAttributes
  extend ActiveSupport::Concern

  class_methods do
    def permitted_attributes
      %i[id line_1 line_2 city postcode country]
    end
  end
end
