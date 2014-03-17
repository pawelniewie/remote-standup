class TeamMailer < ActionMailer::Base
  default from: "pawel@remotestandup.com"
  default from_name: "RemoteStandup"

  def team_update_mail(user, notes)
    @user = user
    @notes = notes

    mail to: user.email,
      from: user.reminder_inbox_email,
      subject: 'Hey, here\' your team update!'
  end

end
