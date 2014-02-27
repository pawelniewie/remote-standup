module ApplicationHelper

	def contact_phone
		'+48 601 789 982'
	end

	def contact_phone_url
		'tel:+48-601-789-982'
	end

	def body_class
    [controller_name, action_name].join('-')
  end

  def user_id
  	session[:user_id]
  end

end
