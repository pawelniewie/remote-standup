class NotesController < ApplicationController
	before_filter :require_user

	def index
		@notes = current_user.notes
	end
end
