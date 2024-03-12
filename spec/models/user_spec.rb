# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:memberships).dependent(:destroy) }
    it { is_expected.to have_many(:app_sessions).dependent(:destroy) }
    it { is_expected.to have_many(:organizations).through(:memberships) }
    it { is_expected.to have_secure_password }
  end

  describe 'validations' do
    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_length_of(:password).is_at_least(8) }
    it { is_expected.to validate_length_of(:password).is_at_most(max_length).with_message('is too long') }

    it 'email should be uniq' do
      create(:user)
      expect(subject).to validate_uniqueness_of(:email).case_insensitive
    end
  end

  describe 'callbacks' do
    it 'stripped the spaces from email and name before saving' do
      user = create(:user, name: ' test ', email: ' new@mail.com ')
      expect(user.name).to eq('test')
    end
  end

  describe '.create_app_session' do
    let(:user) { create(:user, email: 'test@example.com', password: 'password') }

    context 'with valid email and password' do
      it 'creates an app session for the user' do
        expect do
          described_class.create_app_session(email: user.email, password: 'password')
        end.to change(AppSession, :count).by(1)
      end
    end

    context 'with invalid email or password' do
      it 'does not create an app session' do
        expect do
          described_class.create_app_session(email: 'invalid@example.com', password: 'wrongpassword')
        end.not_to change(AppSession, :count)
      end
    end
  end

  describe '.authenticate_app_session' do
    let(:user) { create(:user) }

    context 'with valid app session' do
      it 'authenticate' do
        app_session = user.app_sessions.create!
        expect(
          user.authenticate_app_session(app_session.id, app_session.token)
        ).to eq(app_session)
      end
    end

    context 'with invalid app session' do
      it 'return false' do
        app_session = user.app_sessions.create!
        expect(
          user.authenticate_app_session(app_session.id, 'token')
        ).to be_falsey
      end
    end
  end
end
