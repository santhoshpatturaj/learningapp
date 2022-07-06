module ContentManagement
	class Api::ContentManagement::VotesController < Api::ApplicationController

		before_action :set_vote, only: [:show, :update, :destroy]
		before_action :set_student, only: [:create, :index]


		def index
	    	@votes = Vote.all
	    	json_response(@votes)
  		end

		def create
			@vote = Vote.create!(student_id: @student.id, content_id: vote_params[:content_id],
				upvote: vote_params[:upvote], downvote: vote_params[:downvote])
			json_response(@vote, :created)
		end

		def show
			json_response(@vote)
		end

		def update
			@vote.update(vote_params)
			head :no_content
		end

		def destroy
			@vote.destroy
			head :no_content
		end

		private

		def vote_params
			params.permit(:content_id, :upvote, :downvote)
		end

		def set_vote
			@vote = Vote.find(params[:id])
		end

		def set_student
			@student = current_user
		end
	end
end
