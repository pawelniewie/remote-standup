class IncomingController < ApplicationController
	include Mandrill::Rails::WebHookProcessor
	# authenticate_with_mandrill_keys! 'MANDRILL_WEBHOOKS_KEY'

	def handle_inbound(event_payload)
		matches = /(?<uuid>[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})/.match(event_payload['msg']['from_email'])
		if matches
			begin
				User.find(matches.uuid).notes.create(
					from_email: event_payload['msg']['from_email'],
					from_name: event_payload['msg']['from_name'],
					headers: event_payload['msg']['headers'],
					raw_payload: event_payload.to_s,
					message_text: event_payload['msg']['text'],
					message_html: event_payload['msg']['html'],
	      	note: event_payload['msg']['text']
	      )
	    rescue ActiveRecord::RecordNotFound
	    	logger.warning("No such recipient #{matches.uuid}")
	    end
		else
			logger.warning("Unrecognized recipient #{event_payload['msg']['from_email']}")
		end
  end
end