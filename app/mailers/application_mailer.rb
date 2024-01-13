# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'ankitpariyar.dev@gmail.com'
  layout 'mailer'
end
