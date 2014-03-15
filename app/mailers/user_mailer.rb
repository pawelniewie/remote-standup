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
