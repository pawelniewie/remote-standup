class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :set_csrf_cookie_for_ng
  around_filter :user_time_zone, :if => :current_user

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

  def user_time_zone(&block)
    Time.use_zone(current_user.timezone.blank? ?  'GMT' : current_user.timezone, &block)
  end

  def after_sign_in_path_for(resource)
    # After you enter login info and click submit, I want you to be sent to the registrations#show page
    if current_user.sent_reminder_at.nil?
      settings_path
    else
      discussions_path
    end
  end

end
