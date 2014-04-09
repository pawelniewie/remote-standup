class IncomingController < ApplicationController
	include Mandrill::Rails::WebHookProcessor
	# authenticate_with_mandrill_keys! 'MANDRILL_WEBHOOKS_KEY'

	skip_around_filter :user_time_zone

	def handle_inbound(event_payload)
		incoming = IncomingPayload.new(event_payload)
		target, id = target_and_id(incoming.msg['to'])

		if target and id
			case target
			when 'team'
				Discussion.create_new_discussion(id, incoming)
			when 'discussion'
				Discussion.create_new_note(id, incoming)
			when 'reminder'
				Discussion.create_or_update_discussion(id, incoming)
			end
		else
			logger.warn("Unrecognized recipient: #{incoming.to_address}")
			IncomingMailer.invalid_recipient_mail(incoming.from_address, incoming.to_address).deliver
		end
  end

  private

  def target_and_id(emails)
		emails.each do |to_email, to_name|
			matches = /(?<target>.*)[+-](?<uuid>[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})@/.match(to_email)
			if matches and not matches[:target].blank? and not matches[:uuid].blank?
				return matches[:target], matches[:uuid]
			end
		end
		nil
  end

end