# frozen_string_literal: true

class Listing < ApplicationRecord
  include HasAddress
  include PermittedAttributes

  belongs_to :creator, class_name: 'User'
  belongs_to :organization

  has_one_attached :cover_photo
  has_rich_text :description

  scope :feed, lambda {
    order(created_at: :desc).includes(:address).with_attached_cover_photo
  }

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
  validates :cover_photo, presence: true
  validates :description, presence: true

  before_save :downcase_tags

  private

  def downcase_tags
    self.tags = tags.map(&:downcase)
  end
end
