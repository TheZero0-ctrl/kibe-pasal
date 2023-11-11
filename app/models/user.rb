# frozen_string_literal: true

class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  has_secure_password

  validates :name, presence: true
  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }

  before_validation :strip_extra_space

  private

  def strip_extra_space
    self.name = name&.strip
    self.email = email&.strip
  end
end
