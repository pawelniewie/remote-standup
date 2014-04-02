class NotesController < ApplicationController
	before_filter :authenticate_user!
	before_action :set_discussion

	def index
		@notes = @discussion.notes.order(created_at: :desc)
	end

	private

	def set_discussion
		@discussion = current_user.team.discussions.find(params[:discussion_id])
	end
end
