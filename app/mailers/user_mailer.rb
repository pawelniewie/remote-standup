class UserMailer < ActionMailer::Base
  default from: "pawel@remotestandup.com"

  def reminder_email(user)
    mandrill_mail template: 'User Reminder',
    	from: "reminder-#{user.id}@in.remotestandup.com",
      to: { email: user.email, name: user.full_name },
      vars: {
      	'FIRST_TIME' => true,
      	'MEMBERS' => user.members
      },
      inline_css: true
  end

end
