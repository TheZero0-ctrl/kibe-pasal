# frozen_string_literal: true

FactoryBot.define do
  factory :listing do
    address { build(:address) }
    title { Faker::Commerce.product_name }
    price { Faker::Commerce.price.floor }
    condition { Listing.conditions.values.sample }
    tags { %w[Faker::Commerce.department(max: 1] }
    transient do
      index { 1 }
    end
    cover_photo do
      File.open(Rails.root.join("spec/support/files/test-image-#{index}.jpg"))
    end
  end
end
