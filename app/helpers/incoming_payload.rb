class IncomingPayload
	include NoteExtractor

	def initialize(event_payload)
		@event_payload = event_payload
		@to_address = get_to_from(@event_payload)
		@from_address = get_from_from(@event_payload)
		@from_name = @event_payload['msg']['from_name']
	end

	attr_reader :to_address, :from_address, :from_name

  def msg
    @event_payload['msg']
  end

	def headers
		@event_payload['msg']['headers']
	end

	def raw
		@event_payload.to_s
	end

	def subject
		@event_payload['msg']['subject'].presence || ''
	end

	def message_text
		@event_payload['msg']['text'].presence || ''
	end

	def message_html
		@event_payload['msg']['html'].presence || ''
	end

	def simple_message
		extract_note(@event_payload['msg']['text'])
	end

	def get_to_from(event_payload)
  	event_payload['msg']['to'][0][0]
  end

  def get_from_from(event_payload)
  	event_payload['msg']['from_email']
	end

end