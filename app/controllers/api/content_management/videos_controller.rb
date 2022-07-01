module ContentManagement
	class Api::ContentManagement::VideosController < Api::ApplicationController
		skip_before_action :doorkeeper_authorize!

		before_action :set_video, only: [:show, :update, :destroy]


		def index
	    	@videos = Video.all
	    	json_response(@videos)
  		end

		def create
			@video = Video.create!(video_params)
			json_response(@video, :created)
		end

		def show
			json_response(@video)
		end

		def update
			@video.update(video_params)
			head :no_content
		end

		def destroy
			@video.destroy
			head :no_content
		end

		private

		def video_params
			params.permit(:title, :link, :duration, :thumbnail)
		end

		def set_video
			@video = Video.find(params[:id])
		end
	end
end