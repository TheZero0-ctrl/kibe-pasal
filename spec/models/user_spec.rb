# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:memberships).dependent(:destroy) }
    it { is_expected.to have_many(:organizations).through(:memberships) }
    it { is_expected.to have_secure_password }
  end

  describe 'validations' do
    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_length_of(:password).is_at_least(8) }
    it { is_expected.to validate_length_of(:password).is_at_most(max_length) }

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
end
