class Discussion < ActiveRecord::Base

	has_many :notes
	belongs_to :team

  validates_presence_of :team

	scope :first, -> { order("created_at").first }
	scope :last, -> { order("created_at DESC").first }

  def self.create_new_discussion(team_id, incoming)
  	user = User.find_by_email(incoming.from_address)
  	if not user.nil? and user.team.id == team_id
			discussion = user.team.discussions.new(:title => incoming.subject.presence || 'New discussion')
			discussion.save!
			create_note(user, discussion.notes, incoming)
		else
			IncomingMailer.not_belongs_mail(incoming.from_address).deliver
		end
  end

  def self.create_new_note(discussion_id, incoming)
  	user = User.find_by(:email => incoming.from_address)
  	if not user.nil?
	  	discussion = user.team.discussions.find_by_id(discussion_id)
	  	if not discussion.nil?
				create_note(user, discussion.notes, incoming)
			else
				IncomingMailer.invalid_discussion_mail(incoming.from_address, incoming.to_address).deliver
			end
		else
			IncomingMailer.invalid_recipient_mail(incoming.from_address, incoming.to_address).deliver
		end
  end

  def self.create_or_update_discussion(user_id, incoming)
		user = User.find_by_id(user_id) || User.find_by_email(incoming.from_address)
		unless user.nil?
			Time.use_zone(user.timezone.presence || 'GMT') do
				title = self.reminder_title
				discussion = Discussion.find_by(:title => title, :team_id => user.team.id)
				if discussion.nil?
					discussion = user.team.discussions.new(:title => title)
					discussion.save!
				end
				create_note(user, discussion.notes, incoming)
			end
		else
			IncomingMailer.invalid_recipient_mail(incoming.from_address, incoming.to_address).deliver
		end
  end

  def self.create_note(user, notes, incoming)
  	notes.new(
  		from_email: incoming.from_address,
			from_name: incoming.from_name,
			headers: incoming.headers,
			raw_payload: incoming.raw,
			message_text: incoming.message_text,
			message_html: incoming.message_html,
			note: incoming.simple_message,
			user: user,
			team: user.team).save!
  end

  def self.reminder_title
  	'Team Update from ' + Time.now.to_s(:year_month_day)
  end

end
