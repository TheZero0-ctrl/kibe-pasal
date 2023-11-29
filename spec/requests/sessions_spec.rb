# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST create' do
    let!(:user) { create(:user) }
    let(:valid_params) do
      {
        user: {
          email: user.email,
          password: 'password'
        }
      }
    end
    let(:invalid_params) do
      {
        user: {
          email: user.email,
          password: 'wrongpassword'
        }
      }
    end

    context 'with valid login credentials' do
      it 'create new app session and redirect to root' do
        expect do
          post login_path, params: valid_params
        end.to change(AppSession, :count).by(1)
        expect(response).to redirect_to(root_path)
        expect(cookies[:app_sessions]).to be_present
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid login credentials' do
      it 'renders the new template with unprocessable_entity status' do
        post login_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:danger]).to be_present
        expect(response).to render_template(:new)
      end
    end
  end
end
