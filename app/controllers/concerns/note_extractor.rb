module NoteExtractor

	extend ActiveSupport::Concern

	def extract_note(body)
		lines = EmailReplyParser.parse_reply(body).lines
		if lines[-1] =~ /@in.remotestandup.com/
			lines = lines[0..-2]
		end

		while lines[-1] == "\n"
			lines = lines[0..-2]
		end

		lines.join
  end
end