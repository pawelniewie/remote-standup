class ShareTeamUpdateWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

	recurrence { hourly.minute_of_hour(3, 33) }

  def perform(last_occurrence, current_occurrence)
  	UsersThatShouldGetTeamUpdateNowQuery.new.find_each do |user|
  		logger.info "Queuing team summary for #{user.id} #{user.email}"
  		user.send_team_update
  	end
  end
end