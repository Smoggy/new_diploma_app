# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.delivery_method = :smtp


ActionMailer::Base.smtp_settings = {
   address: "smtp.gmail.com",
   port: 587,
   authentication: :login,
   enable_starttls_auto: true,
   user_name: "shdo@karazin.ua",
   password: "lyudmila7212"
}