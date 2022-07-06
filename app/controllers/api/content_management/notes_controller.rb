module ContentManagement
	class Api::ContentManagement::NotesController < Api::ApplicationController

		before_action :set_note, only: [:show, :update, :destroy]
		before_action :set_student, only: [:create, :index]


		def index
			if note_params[:student_id]
				@notes = Note.where(student_id: note_params[:student_id], content_id: note_params[:content_id])
			else
	    		@notes = Note.where(student_id: @student.id, content_id: note_params[:content_id])
	    	end
	    	json_response(@notes)
  		end

		def create
			@note = Note.create!(student_id: @student.id, content_id: note_params[:content_id],
				note_text: note_params[:note_text])
			json_response(@note, :created)
		end

		def show
			json_response(@note)
		end

		def update
			@note.update(note_params)
			head :no_content
		end

		def destroy
			@note.destroy
			head :no_content
		end

		private

		def note_params
			params.permit(:content_id, :note_text, :student_id)
		end

		def set_note
			@note = Note.find(params[:id])
		end

		def set_student
			@student = current_user
		end
	end
end
