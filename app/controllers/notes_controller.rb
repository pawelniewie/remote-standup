class NotesController < ApplicationController
	before_filter :authenticate_user!

	def index
		@notes = Note.where('user_id IN (:users)',
			:users => User.where('user_id = :admin_id OR admin_id = :admin_id',
				admin_id: current_user.admin.nil? ? current_user.id : current_user.admin.id).select(:id)).order(created_at: :desc)
	end
end
