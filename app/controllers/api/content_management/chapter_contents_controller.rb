module ContentManagement
	class Api::ContentManagement::ChapterContentsController < Api::ApplicationController
		skip_before_action :doorkeeper_authorize!

		before_action :set_chapter_content, only: [:show, :update, :destroy]


		def index
	    	@chapter_contents = ChapterContent.all
	    	json_response(@chapter_contents)
  		end

		def create
			@chapter_content = ChapterContent.create!(chapter_content_params)
			json_response(@chapter_content, :created)
		end

		def show
			json_response(@chapter_content)
		end

		def update
			@chapter_content.update(chapter_content_params)
			head :no_content
		end

		def destroy
			@chapter_content.destroy
			head :no_content
		end

		private

		def chapter_content_params
			params.permit(:chapter_id, :content_id)
		end

		def set_chapter_content
			@chapter_content = ChapterContent.find(params[:id])
		end
	end
end