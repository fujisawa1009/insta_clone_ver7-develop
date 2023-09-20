class ApplicationMailer < ActionMailer::Base
  # メールの送信元となるメールアドレスを指定
  default from: 'instaclone@example.com'
  layout 'mailer'
end
