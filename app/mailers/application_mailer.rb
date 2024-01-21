# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'ankit@truemark.com.np'
  layout 'mailer'
end
