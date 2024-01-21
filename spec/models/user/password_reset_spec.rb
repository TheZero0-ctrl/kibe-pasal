# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::PasswordReset do
  include ActionMailer::TestHelper

  let(:user) { create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
  end

  describe "resetting a user's password" do
    it 'destroys all sessions and sends reset email' do
      user.app_sessions.create!
      user.app_sessions.create!

      expect do
        user.reset_password
      end.to change { ActionMailer::Base.deliveries.count }.by(1)

      user.reload

      expect(user.app_sessions).to be_empty
      expect(user.password_reset_token).not_to be_nil
    end
  end

  describe 'password reset id' do
    let(:user) { FactoryBot.create(:user) }

    it 'can retrieve a user with a valid password reset id' do
      user.reset_password
      password_reset_id = user.send(:password_reset_id)
      retrieved_user = User.find_with_password_reset_id(password_reset_id)

      expect(retrieved_user).to eq(user)
    end

    it 'retrieving a user with an invalid id returns nil' do
      retrieved_user = User.find_with_password_reset_id('invalid')
      expect(retrieved_user).to be_nil
    end

    it 'retrieving a user with an expired id returns nil' do
      user.reset_password
      password_reset_id = user.send(:password_reset_id)

      Timecop.travel(3.hours.from_now)

      retrieved_user = User.find_with_password_reset_id(password_reset_id)
      expect(retrieved_user).to be_nil

      Timecop.return
    end

    it 'nullifies the password reset token when updating the password' do
      user.reset_password
      expect(user.reload.password_reset_token_digest).not_to be_nil

      user.update!(password: 'new_password')

      expect(user.reload.password_reset_token_digest).to be_nil
    end
  end
end
