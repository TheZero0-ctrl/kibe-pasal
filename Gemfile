# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'
gem 'bcrypt', '~> 3.1', '>= 3.1.11'
gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'iso_country_codes', '~> 0.7.8'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'pg', '~> 1.1'
gem 'premailer-rails', '~> 1.12'
gem 'propshaft'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8'
gem 'redis', '~> 4.0'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 3.2', '>= 3.2.3'
  gem 'letter_opener', '~> 1.8', '>= 1.8.1'
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rubocop', '~> 1.57', '>= 1.57.2'
  gem 'rubocop-capybara', '~> 2.19'
  gem 'rubocop-performance', '~> 1.19', '>= 1.19.1'
  gem 'rubocop-rails', '~> 2.22', '>= 2.22.1'
  gem 'rubocop-rspec', '~> 2.25'
  gem 'timecop', '~> 0.9.5'
end

group :development do
  gem 'i18n-debug'
  gem 'web-console'
end

group :test do
  gem 'capybara', '~> 3.39', '>= 3.39.2'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
  gem 'selenium-webdriver', '~> 4.16'
  gem 'shoulda-matchers', '~> 5.0'
end
