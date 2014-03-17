class NotesController < ApplicationController
	before_filter :authenticate_user!

	def index
		@notes = current_user.team.notes.order(created_at: :desc)
	end
end
