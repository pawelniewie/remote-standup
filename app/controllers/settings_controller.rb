class SettingsController < ApplicationController
	before_filter :require_user

	def update
		current_user.update!(params.require(:settings).permit(:timezone, :reminder_at, :remind_on, :members))
	end

end
