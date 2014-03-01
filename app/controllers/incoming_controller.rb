class IncomingController < ApplicationController
	include Mandrill::Rails::WebHookProcessor
	authenticate_with_mandrill_keys! ENV['MANDRILL_WEBHOOKS_KEY']
end