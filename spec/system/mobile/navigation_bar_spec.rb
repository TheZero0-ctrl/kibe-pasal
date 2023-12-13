# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mobile::NavigationBar', type: :system do
  before do
    driven_by :selenium_headless
    visit root_path
    page.current_window.resize_to(375, 812)
  end

  after do
    page.current_window.resize_to(1400, 1400)
  end

  it 'can access sign up page via burger menu' do
    visit root_path
    find('.navbar-burger').click
    click_on I18n.t('shared.navbar.sign_up')
    assert_current_path sign_up_path
  end

  it 'can access login page via burger menu' do
    visit root_path
    find('.navbar-burger').click
    click_on I18n.t('shared.navbar.log_in')
    assert_current_path login_path
  end
end
