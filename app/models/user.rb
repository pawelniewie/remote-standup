class User < ActiveRecord::Base
	belongs_to :team, :inverse_of => :users

	after_initialize :init
  after_create :update_team

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :invitable, :database_authenticatable, :registerable, :confirmable,
				 :recoverable, :rememberable, :trackable, :validatable, :omniauthable

	include Gravtastic

	gravtastic :email,
	  :secure => true,
	  :filetype => :png,
	  :size => 15

	validates_presence_of :email

	has_many :authorizations

	scope :first, -> { order("created_at").first }
	scope :last, -> { order("created_at DESC").first }

	has_many :notes, dependent: :destroy
	has_many :invitations, :class_name => self.to_s, :as => :invited_by

	def members
		@members ||= User.where("team_id = ? AND id != ?", self.team_id, self.id).order('email')
	end

	def self.new_with_session(params,session)
		if session["devise.user_attributes"]
			new(session["devise.user_attributes"],without_protection: true) do |user|
				user.attributes = params
				user.valid?
			end
		else
			super
		end
	end

	def self.from_omniauth(auth, current_user)
		authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s,
			:token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
		if authorization.user.blank?
			user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
			if user.blank?
				user = User.new
				user.password = Devise.friendly_token[0,10]
				user.email = auth.info.email
				user.full_name = auth.info.name if auth.info.respond_to? 'name'
				user.full_name = auth.info.full_name if auth.info.respond_to? 'full_name' and user.full_name.nil?
				user.calling_name = auth.info.given_name if auth.info.respond_to? 'given_name'
				user.male = auth.info.gender == "male" if auth.info.respond_to? 'male'
				auth.provider == "twitter" ? user.save(:validate => false) :  user.save
			end
			authorization.username = auth.info.nickname
			authorization.user_id = user.id
			authorization.save
		end
		authorization.user
	end

	after_invitation_accepted :email_invited_by

	def email_invited_by
   # ...
	end

	def send_todays_reminder
		update_attribute :sent_reminder_at, Time.now
    save
		SendReminderEmailWorker.perform_async(id)
	end

	def send_team_update
		notes_from = self.sent_team_update_at.nil? ? Time.now - 1.day : self.sent_team_update_at
		update_attribute :sent_team_update_at, Time.now
		save
		EmailTeamUpdateWorker.perform_async(id, notes_from)
	end

	def reminder_inbox_email
		"reminder+#{id}@in.remotestandup.com"
	end

	def admin?
		type == 'Admin'
	end

	def update_team
	  # get or create a subdomain on creating a new user
	  unless team
	  	self.team ||= Team.create!
	  	self.save
	  end
	end

	def init
		self.remind_on ||= [1, 2, 3, 4, 5]
	end

end
