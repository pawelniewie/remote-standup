module SettingsHelper
	include ActionView::Helpers::NumberHelper

	def calculate_reminder_at(user)
		"#{user.reminder_at_h.to_s.rjust(2, '0')}:#{user.reminder_at_m.to_s.rjust(2, '0')}"
	end
end
