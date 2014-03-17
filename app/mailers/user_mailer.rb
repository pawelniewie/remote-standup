class UserMailer < MandrillMailer::TemplateMailer
  default from: "pawel@remotestandup.com"
  default from_name: "RemoteStandup"

  def reminder_mail(user)
    mandrill_mail template: 'User Reminder',
    	from: user.reminder_inbox_email,
      subject: 'Hey, what have you done lately?',
      to: { email: user.email, name: user.full_name },
      vars: {
      	'FIRST_TIME' => user.sent_reminder_at.nil?,
      	'MEMBERS' => user.members.inject('') { |sum, user| sum += "<a href='mailto:#{user.email}'>#{user.calling_name.nil? or user.calling_name.empty? ? user.email : user.calling_name}</a> "}
      },
      inline_css: true,
      async: false
  end

  def team_update_mail(user, notes)
    @user = user
    @notes = notes

    mail to: { email: user.email, name.user.full_name },
      from: user.reminder_inbox_email,
      subject: 'Hey, here\' your team update!'
  end

end
