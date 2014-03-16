class NotesController < ApplicationController
	before_filter :authenticate_user!

	def index
		@notes = Note.where('user_id IN (:users)',
			:users => User.where(:team_id => current_user.team.id).select(:id)).order(created_at: :desc)
	end
end
