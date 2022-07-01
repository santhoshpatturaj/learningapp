module Meta
	class Api::Meta::SubjectsController < Api::ApplicationController
		skip_before_action :doorkeeper_authorize!
		before_action :doorkeeper_authorize!, only: [:index]
		before_action :set_student, only: [:index]

		before_action :set_subject, only: [:show, :update, :destroy]


		def index
			@current_grade = @student.grade_id
			@current_board = @student.board_id
	    	@subjects = Subject.where(grade_id: @current_grade, board_id: @current_board)
	    	json_response(@subjects)
  		end

		def create
			@subject = Subject.create!(subject_params)
			json_response(@subject, :created)
		end

		def show
			json_response(@subject)
		end

		def update
			@subject.update(subject_params)
			head :no_content
		end

		def destroy
			@subject.destroy
			head :no_content
		end

		private

		def subject_params
			params.permit(:subject_name, :grade_id, :board_id)
		end

		def set_subject
			@subject = Subject.find(params[:id])
		end

		def set_student
      		@student = current_user
		end
	end
end