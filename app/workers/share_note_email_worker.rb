class ShareNoteEmailWorker
	include Sidekiq::Worker

  def perform(note_id)
    UserMailer.note_mail(Note.find(note_id)).deliver
  end
end