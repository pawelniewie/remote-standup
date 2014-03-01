class UserMailer < MandrillMailer::TemplateMailer
  default from: "pawel@remotestandup.com"
  default from_name: "RemoteStandup"

  def reminder_mail(user)
    mandrill_mail template: 'User Reminder',
    	from: "reminder-#{user.id}@in.remotestandup.com",
      subject: 'Hey, what have you done lately?',
      to: { email: user.email, name: user.full_name },
      vars: {
      	'FIRST_TIME' => true,
      	'MEMBERS' => user.members
      },
      inline_css: true,
      async: false
  end

  def note_mail(user)
    mandrill_mail template: 'User Reminder',
      from: "reminder-#{user.id}@in.remotestandup.com",
      subject: 'Hey, what have you done lately?',
      to: { email: user.email, name: user.full_name },
      vars: {
        'FIRST_TIME' => true,
        'MEMBERS' => user.members
      },
      inline_css: true,
      async: false
  end

end
