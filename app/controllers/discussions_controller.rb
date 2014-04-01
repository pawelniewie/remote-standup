class DiscussionsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@discussions = current_user.team.discussions.order(created_at: :desc)
	end
end
