# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #new' do
    it 'renders the new template' do
      get sign_up_path
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        { user: { name: 'John Doe', email: 'john@example.com', password: 'password' } }
      end

      it 'creates a new user' do
        expect do
          post sign_up_path, params: valid_params
        end.to change(User, :count).by(1)
      end

      it 'creates a new organization with the user as a member' do
        post sign_up_path, params: valid_params
        user = User.find_by(email: 'john@example.com')
        organization = Organization.last
        expect(organization.members).to include(user)
      end

      it 'redirects to root_path with a success flash message' do
        post sign_up_path, params: valid_params
        follow_redirect!
        expect(response).to render_template('feed/show')
        expect(flash[:success]).to be_present
      end

      it 'create app sessions cookies' do
        post sign_up_path, params: valid_params
        expect(cookies[:app_sessions]).to be_present
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { user: { name: '', email: 'invalid_email', password: 'short' } }
      end

      it 'does not create a new user' do
        expect do
          post sign_up_path, params: invalid_params
        end.not_to change(User, :count)
      end

      it 'renders the new template with unprocessable_entity status' do
        post sign_up_path, params: invalid_params
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end
end
