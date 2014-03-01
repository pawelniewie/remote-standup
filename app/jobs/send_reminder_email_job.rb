class SendReminderEmailJob < Struct.new(:id)
  def perform
    UserMailer.reminder_mail(User.find_by(id)).deliver
  end
end