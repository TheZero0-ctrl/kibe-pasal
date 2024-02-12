# frozen_string_literal: true

FactoryBot.define do
  factory :listing do
    title { Faker::Commerce.product_name }
    price { Faker::Commerce.price.floor }
    condition { Listing.conditions.values.sample }
  end
end
