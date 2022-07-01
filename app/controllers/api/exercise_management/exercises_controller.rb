module Exercise_management
	class Api::ExerciseManagement::ExercisesController < Api::ApplicationController
		skip_before_action :doorkeeper_authorize!

		before_action :set_exercise, only: [:show, :update, :destroy]


		def index
	    	@exercises = Exercise.all
	    	json_response(@exercises)
  		end

		def create
			@exercise = Exercise.create!(exercise_params)
			json_response(@exercise, :created)
		end

		def show
			json_response(@exercise)
		end

		def update
			@exercise.update(exercise_params)
			head :no_content
		end

		def destroy
			@exercise.destroy
			head :no_content
		end

		private

		def exercise_params
			params.permit(:title, :marks, :duration, :no_of_questions)
		end

		def set_exercise
			@exercise = Exercise.find(params[:id])
		end
	end
end
