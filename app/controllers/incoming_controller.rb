class IncomingController < ApplicationController
	include NoteExtractor
	include Mandrill::Rails::WebHookProcessor
	# authenticate_with_mandrill_keys! 'MANDRILL_WEBHOOKS_KEY'

	def handle_inbound(event_payload)
		recipient = event_payload['msg']['headers']['To']
		target, id = target_and_id(recipient)
		if target and id
			begin
				if target == 'team'
					notes = Team.find(id).notes
				elsif target == 'discussion'
					notes = Discussion.find(id).notes
				elsif target == 'reminder'
					notes = User.find(id).team.notes
				end

				notes.new(
					from_email: event_payload['msg']['from_email'],
					from_name: event_payload['msg']['from_name'],
					headers: event_payload['msg']['headers'],
					raw_payload: event_payload.to_s,
					message_text: default(event_payload['msg']['text'], ''),
					message_html: default(event_payload['msg']['html'], ''),
	      	note: extract_note(event_payload['msg']['text']),
	      	team: user.team
	      ).save!
	    rescue ActiveRecord::RecordNotFound
	    	logger.warn("No such recipient #{matches[:uuid]}")
	    end
		else
			logger.warn("Unrecognized recipient #{event_payload['msg']['headers']['To']}")
		end
  end

  private

  def default(str, default)
  	str.nil? ? default : str
  end

  def target_and_id(email)
  	matches = /(?<target>).+[+-](?<uuid>[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})/.match(email)
  	if matches and not matches[:target].blank? and not matches[:uuid].blank?
  		matches[:target], matches[:uuid]
  	end
  	nil, nil
  end
end