module Exercise_management
	class Api::ExerciseManagement::AnswersController < Api::ApplicationController

		before_action :set_answer, only: [:show, :update, :destroy]

		def index
	    	@answers = Answer.where(attempt_id: answer_params[:attempt_id])
	    	json_response(@answers)
  		end

		def create
			@answer = Answer.create!(answer_params)
			json_response(@answer, :created)
		end

		def show
			json_response(@answer)
		end

		def update
			@answer.update(answer_params)
			head :no_content
		end

		def destroy
			@answer.destroy
			head :no_content
		end

		def get_result
			score = 0
			@answers = Answer.where(attempt_id: answer_params[:attempt_id])
			@answers.each do | answer |
				question = Question.where(id: answer.question_id).first
				if answer.status != 'not_answered' && answer["option"] == question["correct_answer"]
					score += question.mark
				end
			end
			render(json: { attempt_id: answer_params[:attempt_id],
				score: score }, status: 200)
		end

		private

		def answer_params
			params.permit(:attempt_id, :question_id, :option, :status)
		end

		def set_answer
			@answer = Answer.find(params[:id])
		end
	end
end
