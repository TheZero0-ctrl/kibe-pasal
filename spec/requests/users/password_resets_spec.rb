# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::PasswordResets', type: :request do
  let(:user) { create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
  end

  it 'creates a password reset, sends an email, and shows instructions' do
    post users_password_resets_path, params: {
      email: user.email
    }

    expect(response).to have_http_status(:ok)
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  describe 'GET #edit' do
    context 'with a valid id' do
      before do
        user.reset_password
        get edit_users_password_reset_path(CGI.escape(user.send(:password_reset_id)))
      end

      it 'responds successfully' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the form' do
        expect(response).to render_template(:edit)
      end
    end

    context 'with an invalid or nil id' do
      it 'redirects to new password reset path' do
        get edit_users_password_reset_path('invalid')
        expect(response).to redirect_to(new_users_password_reset_path)

        get edit_users_password_reset_path
        expect(response).to redirect_to(new_users_password_reset_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid password' do
      before do
        user.reset_password
        password_reset_id = CGI.escape(user.send(:password_reset_id))
        patch users_password_reset_path(password_reset_id), params: {
          user: { password: 'W3lcome?' }
        }
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response).to have_http_status(:ok)
      end

      it 'authenticates the user with the new password' do
        expect(user.reload.authenticate('W3lcome?')).to be_truthy
      end
    end

    context 'with too short password' do
      before do
        user.reset_password
        password_reset_id = CGI.escape(user.send(:password_reset_id))
        patch users_password_reset_path(password_reset_id), params: {
          user: { password: 'pw' }
        }
      end

      it 'responds with unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
