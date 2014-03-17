class EmailTeamUpdateWorker
	include Sidekiq::Worker

  def perform(user_id, notes_starting_at)
  	user = User.find(user_id)
  	notes = Note.where('created_at >= ? AND team_id = ?', notes_starting_at, user.team_id).to_a

  	logger.info("Queueing team update for #{user.email} with #{notes.size} notes")
    TeamMailer.team_update_mail(user, notes).deliver
  end
end