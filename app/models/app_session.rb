# frozen_string_literal: true

class AppSession < ApplicationRecord
  belongs_to :user

  has_secure_password :token, validations: false

  before_create :create_token

  def to_h
    {
      user_id: user.id,
      app_session: id,
      token: token
    }
  end

  private

  def create_token
    self.token = self.class.generate_unique_secure_token
  end
end
