# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Passwords', type: :request do
  describe 'PATCH #update' do
    let(:user) { create(:user) }

    before { log_in user }

    context 'with valid current password' do
      let(:valid_params) do
        {
          user: {
            current_password: 'password',
            password: 'new_password'
          }
        }
      end

      it 'update password' do
        patch users_change_password_path, params: valid_params
        expect(response).to redirect_to(profile_path)
        expect(user.reload.authenticate('new_password')).to be_truthy
      end
    end

    context 'with incorrect current password' do
      let(:invalid_params) do
        {
          user: {
            current_password: 'wrong_password',
            password: 'new_password'
          }
        }
      end

      it 'give error response' do
        patch users_change_password_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
