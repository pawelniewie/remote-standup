class SendRemindersWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

	recurrence { hourly.minute_of_hour(0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55) }

  def perform(last_occurrence, current_occurrence)
  	# time = Time.now
  	# users = User.where()
  end
end