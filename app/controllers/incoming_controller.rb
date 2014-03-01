class IncomingController < ApplicationController
	include Mandrill::Rails::WebHookProcessor
	# authenticate_with_mandrill_keys! 'YOUR_MANDRILL_WEBHOOK_KEY'
end