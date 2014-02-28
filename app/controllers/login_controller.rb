class LoginController < ApplicationController
	before_action :set_google, only: [:google, :google_callback]

	def index
		flash[:notice] = 'You have been logged out'
		redirect_to :controller => 'welcome'
	end

	def logout
		session[:user_id] = nil
		flash[:notice] = 'You have been logged out'
		redirect_to :controller => 'welcome'
	end

	def google
	  session[:user_id] = nil
	  session[:state] = Digest::MD5.hexdigest(rand().to_s)

	  redirect_to @google.auth_code.authorize_url(:redirect_uri => url_for(:action => 'google_callback'),
	    :scope => 'profile email openid',
	    :access_type => "online", :state => session[:state]), :status => 303
	end

	def google_callback
	  unless session[:state] == params[:state]
	  	redirect_to :controller => 'welcome', :action => 'index'
	  	return
	  end

	  access_token = @google.auth_code.get_token(params[:code], :redirect_uri => url_for(:action => 'google_callback'))
	  profile = access_token.get('https://www.googleapis.com/oauth2/v1/userinfo?alt=json').parsed.with_indifferent_access
	  logger.info("Profile is #{profile.to_json}")

	  user = User.where(email: profile[:email]).first
	  if not user
	    logger.info("User was not found " + profile[:email])
	    user = User.create!(email: profile[:email], full_name: profile[:name], calling_name: profile[:given_name],
	      picture: profile[:picture], male: profile[:gender] == "male")
	  end

	  session[:user_id] = user.id.to_s
	  redirect_to :controller => 'settings', :action => 'show'
	end

	private
		def set_google
		  @google ||= ::OAuth2::Client.new(ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], {
		    :site => 'https://accounts.google.com',
		    :authorize_url => "/o/oauth2/auth",
		    :token_url => "/o/oauth2/token"
		  })
		end
end