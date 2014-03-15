class SettingsController < ApplicationController
	before_filter :authenticate_user!

	def update
		current_user.update!(params.require(:settings).permit(:timezone, :reminder_at_h, :reminder_at_m, :remind_on => []))

		if current_user.sent_reminder_at.nil?
			current_user.send_todays_reminder
		end

		respond_to do |format|
			format.html { redirect_to :action => 'show', notice: 'Settings were saved.' }
			format.json { head :no_content }
		end
	end

end
