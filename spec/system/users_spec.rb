# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user) { create(:user) }

  before do
    driven_by :selenium_headless, screen_size: [1400, 1400]
  end

  it 'allows a new user to sign up' do
    visit root_path
    click_on I18n.t('shared.navbar.sign_up')

    fill_in User.human_attribute_name(:name), with: 'test'
    fill_in User.human_attribute_name(:email), with: 'test@example.com'
    fill_in User.human_attribute_name(:password), with: 'short'
    click_on I18n.t('users.new.sign_up')

    assert_selector 'p.error-text', text: I18n.t('activerecord.errors.models.user.attributes.password.too_short')

    fill_in User.human_attribute_name(:password), with: 'password'
    click_on I18n.t('users.new.sign_up')

    assert_current_path root_path
    assert_selector '.notification', text: I18n.t('users.create.welcome', name: 'test')
    assert_selector '.navbar-dropdown', visible: false
  end

  it 'allows an existing user to log in' do
    visit root_path
    click_on I18n.t('shared.navbar.log_in')

    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: 'wrong'
    click_button I18n.t('sessions.new.login')

    assert_selector '.notification', text: I18n.t('sessions.create.incorrect_details')

    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: 'password'
    click_button I18n.t('sessions.new.login')

    assert_current_path root_path
    assert_selector '.notification', text: I18n.t('sessions.create.success')
    assert_selector '.navbar-dropdown', visible: false
  end

  it 'can update user name' do
    system_login(user)
    visit profile_path
    fill_in User.human_attribute_name(:name), with: 'Updated name'
    click_button I18n.t('users.show.save_profile')

    expect(page).to have_selector('form .notification', text: I18n.t('users.update.success'))
    expect(page).to have_selector('#current_user_name', text: 'Updated name')
  end
end
