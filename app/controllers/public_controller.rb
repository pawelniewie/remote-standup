class PublicController < ApplicationController

	before_action :set_note, only: [:show]

	def show
		render :show, layout: 'public'
	end

	private

	def set_note
		@note = Note.find_by_token(params[:token])
	end

end
