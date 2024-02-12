# frozen_string_literal: true

class Listing < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :organization

  enum condition: {
    brand_new: 'brand_new',
    like_new: 'like_new',
    used: 'used',
    not_working: 'not_working'
  }

  validates :title, length: { in: 10..100 }
  validates :price, numericality: { only_integer: true }
  validates :condition, presence: true
end
