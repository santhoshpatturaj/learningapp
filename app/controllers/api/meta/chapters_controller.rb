module Meta
	class Api::Meta::ChaptersController < Api::ApplicationController
		skip_before_action :doorkeeper_authorize!
		before_action :set_chapter, only: [:show, :update, :destroy]


		def index
	    	@chapters = Chapter.where(subject_id: chapter_params[:subject_id])
	    	json_response(@chapters)
  		end

		def create
			@chapter = Chapter.create!(chapter_params)
			json_response(@chapter, :created)
		end

		def show
			json_response(@chapter)
		end

		def update
			@chapter.update(chapter_params)
			head :no_content
		end

		def destroy
			@chapter.destroy
			head :no_content
		end

		private

		def chapter_params
			params.permit(:subject_id, :chapter_name)
		end

		def set_chapter
			@chapter = Chapter.find(params[:id])
		end
	end
end