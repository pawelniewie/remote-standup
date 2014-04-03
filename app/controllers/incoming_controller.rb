class IncomingController < ApplicationController
	include NoteExtractor
	include Mandrill::Rails::WebHookProcessor
	# authenticate_with_mandrill_keys! 'MANDRILL_WEBHOOKS_KEY'

	def handle_inbound(event_payload)
		recipient = event_payload['msg']['headers']['To']
		target, id = target_and_id(event_payload['msg']['to'])
		if target and id
			begin
				if target == 'team'
					user = User.find(:email => event_payload['msg']['from_email'])
					discussion = Team.find(id).discussions.new(:title => event_payload['msg']['subject'].presence || 'New discussion').save!
					notes = discussion.notes
				elsif target == 'discussion'
					notes = Discussion.find(id).notes
					user = User.find(:email => event_payload['msg']['from_email'])
				elsif target == 'reminder'
					user = User.find(id)
					Time.use_zone(user.timezone.presence || 'GMT') do
						title = 'Team Update from ' + Time.now.to_s(:year_month_day)
						discussion = Discussion.find_by_title(title)
						if discussion.nil?
							discussion = user.team.discussions.new(:title => title).save!
						end
					end
					notes = discussion.notes
				end

				notes.new(
					from_email: event_payload['msg']['from_email'],
					from_name: event_payload['msg']['from_name'],
					headers: event_payload['msg']['headers'],
					raw_payload: event_payload.to_s,
					message_text: event_payload['msg']['text'].presence || '',
					message_html: event_payload['msg']['html'].presence || '',
	      	note: extract_note(event_payload['msg']['text'])
	      ).save!
	    rescue ActiveRecord::RecordNotFound
				logger.warn("Unrecognized recipient #{recipient}")
	    	IncomingMailer.invalid_recipient_mail(event_payload['msg']['from_email'], recipient).deliver
	    rescue => e
	    	logger.error("No such recipient or other error #{e}")
	    end
		else
			logger.warn("Unrecognized recipient #{recipient}")
			IncomingMailer.invalid_recipient_mail(event_payload['msg']['from_email'], recipient).deliver
		end
  end

  private

  def target_and_id(emails)
  	emails.each do |to_email, to_name|
	  	matches = /(?<target>).+[+-](?<uuid>[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})@/.match(to_email)
	  	if matches and not matches[:target].blank? and not matches[:uuid].blank?
	  		return matches[:target], matches[:uuid]
	  	end
	  end
  	nil
  end
end