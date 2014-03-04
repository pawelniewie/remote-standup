class SendReminderEmailWorker
	include Sidekiq::Worker

  def perform(user_id)
  	user = User.find(user_id)
    UserMailer.reminder_mail(user).deliver
    user.sent_reminder_at = Time.now
    user.save
  end
end