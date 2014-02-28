class SettingsController < ApplicationController
	before_filter :require_user

	def update
		current_user.update!(params.require(:settings).permit(:timezone, :reminder_at_h, :reminder_at_m, :remind_on, :members => []))
	end

end
