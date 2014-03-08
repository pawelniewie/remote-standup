class SendRemindersWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

	recurrence { hourly.minute_of_hour(0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55) }

  def perform(last_occurrence, current_occurrence)
  	UsersThatShouldGetReminderNowQuery.new.find_each do |user|
  		logger.info "Queuing reminder for #{user.id} #{user.email}"
  		user.send_todays_reminder
  	end
  end
end