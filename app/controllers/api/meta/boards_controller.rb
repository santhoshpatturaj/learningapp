module Meta
	class Api::Meta::BoardsController < Api::ApplicationController
		skip_before_action :doorkeeper_authorize!

		before_action :set_board, only: [:show, :update, :destroy]


		def index
	    	@boards = Board.all
	    	json_response(@boards)
  		end

		def create
			@board = Board.create!(board_params)
			json_response(@board, :created)
		end

		def show
			json_response(@board)
		end

		def update
			@board.update(board_params)
			head :no_content
		end

		def destroy
			@board.destroy
			head :no_content
		end

		private

		def board_params
			params.permit(:name, :description)
		end

		def set_board
			@board = Board.find(params[:id])
		end
	end
end