module ContentManagement
	class Api::ContentManagement::StudentCompletesController < Api::ApplicationController

		before_action :set_student_complete, only: [:show, :update, :destroy]
		before_action :set_student, only: [:create, :index]


		def index
	    	@student_completes = StudentComplete.where(student_id: @student.id)
	    	json_response(@student_completes)
  		end

		def create
			@student_complete = StudentComplete.create!(student_id: @student.id, 
				type_id: student_complete_params[:type_id], 
				type_name: student_complete_params[:type_name],
				completed: student_complete_params[:completed])
			json_response(@student_complete, :created)
		end

		def show
			json_response(@student_complete)
		end

		def update
			@student_complete.update(student_complete_params)
			head :no_content
		end

		def destroy
			@student_complete.destroy
			head :no_content
		end

		private

		def student_complete_params
			params.permit(:type_name, :type_id, :completed)
		end

		def set_student_complete
			@student_complete = StudentComplete.find(params[:id])
		end

		def set_student
			@student = current_user
		end
	end
end