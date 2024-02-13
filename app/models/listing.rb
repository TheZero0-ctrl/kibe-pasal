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
  validates :tags, length: { in: 1..5 }

  before_save :downcase_tags

  private

  def downcase_tags
    self.tags = tags.map(&:downcase)
  end
end
