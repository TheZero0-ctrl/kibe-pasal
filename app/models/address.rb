# frozen_string_literal: true

class Address < ApplicationRecord
  include PermittedAttributes
  belongs_to :addressable, polymorphic: true

  attribute :country, default: 'NP'

  validates :line_1, presence: true
  validates :line_2, presence: true
  validates :city, presence: true
  validates :postcode, presence: true
  validates :country, presence: true

  def redacted
    "#{city}, #{postcode}"
  end
end
