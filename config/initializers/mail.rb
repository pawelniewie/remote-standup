ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587,
    :user_name => ENV['MANDRILL_USERNAME'],
    :password  => ENV['MANDRILL_APIKEY'],
    :domain    => 'in.remotestandup.com'
  }

ActionMailer::Base.delivery_method = :smtp
