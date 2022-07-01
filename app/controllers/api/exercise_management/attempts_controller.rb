module Exercise_management
	class Api::ExerciseManagement::AttemptsController < Api::ApplicationController

		before_action :set_attempt, only: [:show, :update, :destroy]
		before_action :set_student


		def index
	    	@attempts = Attempt.where(exercise_id: attempt_params[:exercise_id], student_id: @student.id)
	    	json_response(@attempts)
  		end

		def create
			@attempt = Attempt.create!(start_time: attempt_params[:start_time], end_time: attempt_params[:end_time],
				score: attempt_params[:score], pass: attempt_params[:pass], 
				exercise_id: attempt_params[:exercise_id], student_id: @student.id)
			json_response(@attempt, :created)
		end

		def show
			json_response(@attempt)
		end

		def update
			@attempt.update(attempt_params)
			head :no_content
		end

		def destroy
			@attempt.destroy
			head :no_content
		end

		private

		def attempt_params
			params.permit(:start_time, :end_time, :score, :pass, :exercise_id)
		end

		def set_attempt
			@attempt = Attempt.find(params[:id])
		end

		def set_student
      		@student = current_user
    	end	

	end
end

