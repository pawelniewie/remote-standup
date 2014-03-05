class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :invitable, :database_authenticatable, :registerable, :confirmable,
				 :recoverable, :rememberable, :trackable, :validatable, :omniauthable

	validates_presence_of :email

	has_many :authorizations

	scope :first, -> { order("created_at").first }
	scope :last, -> { order("created_at DESC").first }

	has_many :notes, dependent: :destroy
	has_many :invitations, :class_name => self.to_s, :as => :invited_by
	belongs_to :admin, :class_name => self.to_s

	def members
		User.where(:admin => self.admin.nil? ? self.admin : self)
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
end
