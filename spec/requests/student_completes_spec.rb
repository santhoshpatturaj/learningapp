require 'rails_helper'

RSpec.describe 'StudentCompletes API', type: :request do
  # initialize test data
  let!(:student) { create(:student) }
  let(:student_id) { student.id }
  let!(:grade) { create(:grade) }
  let(:grade_id) { grade.id }
  let!(:board) { create(:board) }
  let(:board_id) { board.id }
  let!(:subject) { create(:subject, grade_id: grade_id, board_id: board_id) }
  let(:subject_id) { subject.id }
  before { student.grade_id = grade_id }
  before { student.board_id = board_id }
  let!(:pdf) { create(:pdf) }
  let(:pdf_id) { pdf.id }
  let!(:content) { create(:content, type_name: 'pdf', type_id: pdf_id) }
  let(:content_id) { content.id }
  let!(:video) { create(:video) }
  let(:video_id) { video.id }
  let!(:content2) { create(:content, type_name: 'video', type_id: video_id) }
  let(:content2_id) { content2.id }

  let!(:student_complete) { create(:student_complete, 
    student_id: student_id,
    type_name: 'content',
    type_id: content_id,
    completed: true
    ) }

  let(:student_complete_id) { student_complete.id }

  # Test suite for GET /student_completes
  describe 'GET /api/content_management/student_completes' do
    # make HTTP get request before each example
    before { login(student) }
    #before { student_complete }
    before { get '/api/content_management/student_completes' }

    it 'returns student_completes' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /student_completes/:id
  describe 'GET /api/content_management/student_completes/:id' do
    before { login(student) }
    before { get "/api/content_management/student_completes/#{student_complete_id}" }

    context 'when the record exists' do
      it 'returns the student_complete' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(student_complete_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:student_complete_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find StudentComplete/)
      end
    end
  end

  # Test suite for POST /student_completes
  describe 'POST /api/content_management/student_completes' do
    # valid payload 
    let(:valid_attributes) { { 
      student_id: student_id,
      type_name: 'content',
      type_id: content2_id,
      completed: true
     } }

    context 'when the request is valid' do
      before { login(student) }
      before { post '/api/content_management/student_completes', params: valid_attributes }

      it 'creates a student_complete' do
        expect(json['type_id']).to eq(content2_id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { login(student) }
      before { post '/api/content_management/student_completes', params: { 
        student_id: student_id,
        type_name: 'content',
        type_id: content2_id
      } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Completed is not included in the list/)
      end
    end
  end

  # Test suite for PUT /student_completes/:id
  describe 'PUT /api/content_management/student_completes/:id' do
    let(:valid_attributes) { { 
      completed: false
     } }

    context 'when the record exists' do
      before { login(student) }
      before { put "/api/content_management/student_completes/#{student_complete_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /student_completes/:id
  describe 'DELETE /api/content_management/student_completes/:id' do
    before { login(student) }
    before { delete "/api/content_management/student_completes/#{student_complete_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end