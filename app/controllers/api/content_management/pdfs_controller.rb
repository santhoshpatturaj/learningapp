module ContentManagement
	class Api::ContentManagement::PdfsController < Api::ApplicationController
		skip_before_action :doorkeeper_authorize!

		before_action :set_pdf, only: [:show, :update, :destroy]


		def index
	    	@pdfs = Pdf.all
	    	json_response(@pdfs)
  		end

		def create
			@pdf = Pdf.create!(pdf_params)
			json_response(@pdf, :created)
		end

		def show
			json_response(@pdf)
		end

		def update
			@pdf.update(pdf_params)
			head :no_content
		end

		def destroy
			@pdf.destroy
			head :no_content
		end

		private

		def pdf_params
			params.permit(:title, :file)
		end

		def set_pdf
			@pdf = Pdf.find(params[:id])
		end
	end
end