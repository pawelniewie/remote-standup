class IncomingMailer < ActionMailer::Base
  default from: "pawel@remotestandup.com"
  default from_name: "RemoteStandup"

  def invalid_recipient_mail(to_address, recipient)
    @sender_email = to_address
    @recipient_email = recipient

    mail to: to_address,
      subject: 'Sorry, but there\'s no such inbox :-('
  end

  def not_belongs_mail(to_address)
    mail to: to_address,
      subject: 'Sorry, but you\'re not part of the team :-('
  end
end
