# frozen_string_literal: true

module AuthenticationHelper
  def log_in(user, password: 'password')
    post login_path, params: {
      user: {
        email: user.email,
        password: password
      }
    }
  end

  def system_login(user, password: 'password')
    visit login_path
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: password
    click_button I18n.t('sessions.new.login')
    expect(page).to have_current_path(root_path)
  end
end
