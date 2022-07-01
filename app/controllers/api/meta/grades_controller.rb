module Meta
	class Api::Meta::GradesController < Api::ApplicationController
		skip_before_action :doorkeeper_authorize!

		before_action :set_grade, only: [:show, :update, :destroy]


		def index
	    	@grades = Grade.all
	    	json_response(@grades)
  		end

		def create
			@grade = Grade.create!(grade_params)
			json_response(@grade, :created)
		end

		def show
			json_response(@grade)
		end

		def update
			@grade.update(grade_params)
			head :no_content
		end

		def destroy
			@grade.destroy
			head :no_content
		end

		private

		def grade_params
			params.permit(:title)
		end

		def set_grade
			@grade = Grade.find(params[:id])
		end
	end
end