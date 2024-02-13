# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Listing, type: :model do
  let(:user) { create(:user) }
  let(:organization) { Organization.create! }
  let(:listing) { build(:listing, creator: user, organization: organization) }

  it 'downcase tags before saving' do
    listing.tags = %w[Electronics Tools]
    listing.save!

    expect(listing.tags).to eq(%w[electronics tools])
  end
end
