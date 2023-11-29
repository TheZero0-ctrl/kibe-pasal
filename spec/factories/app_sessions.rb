# frozen_string_literal: true

FactoryBot.define do
  factory :app_session do
    user
    token_digest { 'MyString' }
  end
end
