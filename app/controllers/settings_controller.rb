class SettingsController < ApplicationController
	before_filter :require_user

	def update
		current_user.update!(params.require(:settings).permit(:timezone, :reminder_at_h, :reminder_at_m, :remind_on, :members => []))

		#if first_time?
		Delayed::Job.enqueue( SendReminderEmailJob.new(id: current_user.id) )

		respond_to do |format|
			format.html { redirect_to :action => 'show', notice: 'Settings were saved.' }
			format.json { head :no_content }
		end
	end

end
