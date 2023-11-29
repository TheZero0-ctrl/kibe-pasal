# frozen_string_literal: true

class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :app_sessions, dependent: :destroy
  has_secure_password

  validates :name, presence: true
  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }

  before_validation :strip_extra_space

  def self.create_app_session(email:, password:)
    user = find_by(email: email.downcase)
    return unless user

    user.app_sessions.create! if user.authenticate(password)
  end

  def authenticate_app_session(app_session_id, token)
    app_sessions.find(app_session_id).authenticate_token(token)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  private

  def strip_extra_space
    self.name = name&.strip
    self.email = email&.strip
  end
end
