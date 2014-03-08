class SendReminderEmailWorker
	include Sidekiq::Worker

  def perform(user_id)
    UserMailer.reminder_mail(User.find(user_id)).deliver
  end
end