# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AppSession, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_secure_password(:token) }
  end

  describe 'callback' do
    it 'generates a unique token before create' do
      app_session = build(:app_session, token: nil)
      app_session.save!
      expect(app_session.token).to be_present
    end
  end
end
