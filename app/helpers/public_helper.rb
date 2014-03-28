module PublicHelper

	def public_board_path(board)
    "/p/n/#{board.token}"
	end

	def public_note_url(board)
		"#{request.protocol}#{request.host_with_port}" + public_board_path(board)
	end

end