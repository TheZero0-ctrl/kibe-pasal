require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
  end

  describe 'password reset' do
    it 'sends a password reset email' do
      email = described_class.with(user: user).password_reset.deliver_now

      expect(ActionMailer::Base.deliveries.count).to eq(1)

      expect(email.to).to eq([user.email])
      expect(email.subject).to include('password reset')
      expect(email).to have_selector('a.button')
    end
  end
end
