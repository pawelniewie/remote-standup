module SettingsHelper
	def calculate_reminder_at(user)
		"#{user.reminder_at_h}:#{user.reminder_at_m}"
	end
end
