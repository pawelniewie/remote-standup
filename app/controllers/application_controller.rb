class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :set_csrf_cookie_for_ng

  private

  def set_csrf_cookie_for_ng
  	if protect_against_forgery?
  		cookies['XSRF-TOKEN'] = {
  			value: form_authenticity_token,
  			domain: ENV['COOKIE_DOMAIN']
  		}
  	end
  end

  def verified_request?
  	super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def return_status_accepted
    render :nothing => true, :status => :accepted
  end

  def user_id
    session[:user_id]
  end

  def load_user
    if not user_id.nil?
      @user = ::User.where({ :id => user_id }).first
      if @user.nil?
        redirect_to(:controller => 'login') and return false
      end
    else
      redirect_to(:controller => 'login') and return false
    end
  end

end
