class ShareNoteEmailJob < Struct.new(:id)
  def perform
    UserMailer.note_mail(Note.find_by(id)).deliver
  end
end