# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:memberships).dependent(:destroy) }
    it { is_expected.to have_many(:organizations).through(:memberships) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it 'email should be uniq' do
      create(:user)
      expect(subject).to validate_uniqueness_of(:email).case_insensitive
    end
  end
end
