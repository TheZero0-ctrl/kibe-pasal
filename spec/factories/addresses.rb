# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    line_1 { Faker::Address.street_address }
    line_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    country { 'NP' }
    postcode { Faker::Address.postcode }
  end
end
