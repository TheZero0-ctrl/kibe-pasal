# frozen_string_literal: true

class UserMailer < ApplicationMailer
  before_action { @user = params[:user] }
  default to: -> { ActionMailer::Base.email_address_with_name(@user.email, @user.name) }
  def password_reset(id)
    @password_reset_id = id

    mail subject: t('.subject')
  end
end
