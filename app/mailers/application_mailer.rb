class ApplicationMailer < ActionMailer::Base
  default from: ENV["SUPPORT_MAIL"]
  layout 'mailer'
end
