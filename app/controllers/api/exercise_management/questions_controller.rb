module Exercise_management
	class Api::ExerciseManagement::QuestionsController < Api::ApplicationController
		skip_before_action :doorkeeper_authorize!

		before_action :set_question, only: [:show, :update, :destroy]


		def index
	    	@questions = Question.where(exercise_id: question_params[:exercise_id])
	    	json_response(@questions)
  		end

		def create
			@question = Question.create!(question_params)
			json_response(@question, :created)
		end

		def show
			json_response(@question)
		end

		def update
			@question.update(question_params)
			head :no_content
		end

		def destroy
			@question.destroy
			head :no_content
		end

		private

		def question_params
			params.permit(:text, :option1, :option2, :option3, :option4, :correct_answer,
			:mark, :exercise_id)
		end

		def set_question
			@question = Question.find(params[:id])
		end
	end
end
