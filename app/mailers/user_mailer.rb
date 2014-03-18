class UserMailer < ActionMailer::Base
  default from: "pawel@remotestandup.com"
  default from_name: "RemoteStandup"

  def reminder_mail(user)
    @first_time = user.sent_reminder_at.nil?
    @user = user
    @members = user.members

    mail to: get_email(user),
    	from: user.reminder_inbox_email,
      subject: 'Hey, what have you done lately?'
  end

  def team_update_mail(user, notes)
    @user = user
    @notes = notes

    mail to: get_email(user),
      from: user.reminder_inbox_email,
      subject: 'Hey, here\' your team update!'
  end

  private

  def get_email(user)
    if user.full_name.nil?
      user.email
    else
      "#{user.full_name} <#{user.email}>"
    end
  end

end
