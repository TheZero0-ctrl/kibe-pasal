FactoryBot.define do
  factory :listing do
    title { Faker::Commerce.product_name }
    price { Faker::Commerce.price.floor }
  end
end
