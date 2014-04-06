class IncomingController < ApplicationController
	include NoteExtractor
	include Mandrill::Rails::WebHookProcessor
	# authenticate_with_mandrill_keys! 'MANDRILL_WEBHOOKS_KEY'

	skip_around_filter :user_time_zone

	def handle_inbound(event_payload)
		target, id = target_and_id(event_payload['msg']['to'])

		if target and id
			begin
				case target
				when 'team'
					create_new_discussion(id, event_payload)
				when 'discussion'
					create_new_note(id, event_payload)
				when 'reminder'
					create_or_update_discussion(id, event_payload)
				end
			rescue => e
				logger.error("No such recipient or other error #{e}")
			end
		else
			logger.warn("Unrecognized recipient #{get_to_from(event_payload)}")
			IncomingMailer.invalid_recipient_mail(event_payload['msg']['from_email'], get_to_from(event_payload)).deliver
		end
  end

  private

  def create_new_discussion(team_id, event_payload)
  	user = User.find_by_email(event_payload['msg']['from_email'])
  	if user and user.team.id == team_id
			discussion = user.team.discussions.new(:title => event_payload['msg']['subject'].presence || 'New discussion').save!
			notes = discussion.notes
			create_note(notes, event_payload)
		end
		IncomingMailer.not_belongs_mail(event_payload['msg']['from_email']).deliver
  end

  def create_new_note(discussion_id, event_payload)
  	notes = Discussion.find(id).notes
		user = User.find(:email => event_payload['msg']['from_email'])
		create_note(notes, event_payload)
  end

  def create_or_update_discussion(user_id, event_payload)
		user = User.find(id)
		Time.use_zone(user.timezone.presence || 'GMT') do
			title = 'Team Update from ' + Time.now.to_s(:year_month_day)
			discussion = Discussion.find_by_title(title)
			if discussion.nil?
				discussion = user.team.discussions.new(:title => title).save!
			end
		end
		create_note(discussion.notes, event_payload)
  end

  def create_note(notes, event_payload)
  	notes.new(
			from_email: event_payload['msg']['from_email'],
			from_name: event_payload['msg']['from_name'],
			headers: event_payload['msg']['headers'],
			raw_payload: event_payload.to_s,
			message_text: event_payload['msg']['text'].presence || '',
			message_html: event_payload['msg']['html'].presence || '',
			note: extract_note(event_payload['msg']['text'])).save!
  end

  def target_and_id(emails)
		emails.each do |to_email, to_name|
			matches = /(?<target>.*)[+-](?<uuid>[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})@/.match(to_email)
			if matches and not matches[:target].blank? and not matches[:uuid].blank?
				return matches[:target], matches[:uuid]
			end
		end
		nil
  end

  def get_to_from(event_payload)
  	event_payload['msg']['to'][0][0]
  end

end