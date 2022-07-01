module Content_management
	class Api::ContentManagement::ContentsController < Api::ApplicationController
		skip_before_action :doorkeeper_authorize!
		before_action :set_content, only: [:show, :update, :destroy]


		def index
	    	@contents = Content.all
	    	json_response(@contents)
  		end

		def create
			@content = Content.create!(content_params)
			json_response(@content, :created)
		end

		def show
			json_response(@content)
		end

		def update
			@content.update(content_params)
			head :no_content
		end

		def destroy
			@content.destroy
			head :no_content
		end

		private

		def content_params
			params.permit(:sno, :type_name, :type_id)
		end

		def set_content
			@content = Content.find(params[:id])
		end

		def set_student
      		@student = current_user
		end
	end
end