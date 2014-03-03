class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def all
		p env["omniauth.auth"]
		@user = User.from_omniauth(env["omniauth.auth"], current_user)
		if @user.persisted?
			flash[:notice] = 'Successfully authenticated.'
			sign_in_and_redirect @user, :event => :authentication
		else
			session["devise.user_attributes"] = @user.attributes
			redirect_to new_user_registration_url
		end
	end

	def failure
		super
	end

	alias_method :facebook, :all
	alias_method :twitter, :all
	alias_method :linkedin, :all
	alias_method :github, :all
	alias_method :passthru, :all
	alias_method :google_oauth2, :all
end