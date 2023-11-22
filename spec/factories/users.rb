# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Name' }
    sequence(:email) { |n| "test#{n}@mail.com" }
    password { 'password' }
  end
end
