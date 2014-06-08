# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.delivery_method = :smtp


ActionMailer::Base.smtp_settings = {
   address: "smtp.ukr.net",
   port: 2525,
   authentication: :plain,
   tls: true,
   user_name: "test_mailer@ukr.net",
   password: "qwerty123"
}