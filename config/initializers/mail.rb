Mail.defaults do
  retriever_method :pop3, :address    => "pop3.ukr.net",
                          :port       => 995,
                          :user_name  => 'test_mailer',
                          :password   => 'qwerty123',
                          :enable_ssl => true
end