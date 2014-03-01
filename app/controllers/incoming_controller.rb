class IncomingController < ApplicationController
	include Mandrill::Rails::WebHookProcessor
	# authenticate_with_mandrill_keys! 'MANDRILL_WEBHOOKS_KEY'

	def handle_inbound(event_payload)
		logger.debug(event_payload)
  end
end