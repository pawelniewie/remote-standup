module ApplicationHelper

	def contact_phone
		'+48 601 789 982'
	end

	def contact_phone_url
		'tel:+48-601-789-982'
	end

	def contact_email
		'janek@remotestandup.com'
	end

	def body_class
    [controller_name, action_name].join('-')
  end

  def is_active? controller: controller, action: action
  	controller_name == controller and (action.nil? or action_name == action)
  end

end
