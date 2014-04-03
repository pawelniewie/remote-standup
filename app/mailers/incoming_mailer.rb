class IncomingMailer < ActionMailer::Base
  default from: "pawel@remotestandup.com"
  default from_name: "RemoteStandup"

  def invalid_recipient_mail(to_address, recipient)
    @sender_email = to_address
    @recipient_email = recipient

    mail to: to_address,
      subject: 'Sorry, but there\'s no such inbox :-('
  end
end
