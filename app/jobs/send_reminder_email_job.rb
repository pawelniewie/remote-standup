class SendReminderEmailJob < Struct.new(:id)
  def perform
  	user = User.find_by(id)
    UserMailer.reminder_mail(user).deliver
    user.sent_reminder_at = Time.now
    user.save
  end
end