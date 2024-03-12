require 'rails_helper'

RSpec.describe 'ListingsController', type: :request do
  let(:user) { create(:user, name: 'jerry') }

  before do
    user.organizations << Organization.create
    log_in(user)
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        listing: {
          title: Faker::Commerce.product_name,
          price: Faker::Commerce.price.floor,
          tags: %w[Electronics],
          condition: 'brand_new',
          address_attributes: build(:address).attributes,
          cover_photo: fixture_file_upload(Rails.root.join('spec/support/files/test-image-1.jpg'))
        }
      }
    end

    it 'creates a listing' do
      expect do
        post listings_path, params: valid_params
      end.to change(Listing, :count).by(1)

      expect(response).to redirect_to(listing_path(Listing.last))
    end

    it 'renders unprocessable entity when creating an invalid listing' do
      expect do
        post listings_path, params: {
          listing: {
            title: 'title',
            price: 300
          }
        }
      end.not_to change(Listing, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH #update' do
    it 'updates a listing' do
      listing = create(:listing, creator: user, organization: Organization.first)

      new_title = Faker::Commerce.product_name

      patch listing_path(listing), params: {
        listing: {
          title: new_title,
          price: listing.price
        }
      }

      expect(response).to redirect_to(listing_path(listing))
      expect(listing.reload.title).to eq(new_title)
    end

    it 'renders unprocessable entity when updating a listing with invalid data' do
      listing = create(:listing, creator: user, organization: Organization.first)

      patch listing_path(listing), params: {
        listing: {
          title: listing.title,
          price: 'NaN'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a listing' do
      listing = create(:listing, creator: user, organization: Organization.first)

      expect do
        delete listing_path(listing)
      end.to change(Listing, :count).by(-1)

      expect(response).to redirect_to(my_listings_path)
    end
  end
end
