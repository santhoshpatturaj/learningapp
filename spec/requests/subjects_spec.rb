require 'rails_helper'

RSpec.describe 'Subjects API', type: :request do
  # initialize test data
  let!(:student) { create(:student) }
  let(:student_id) { student.id }
  let!(:grade) { create(:grade) }
  let(:grade_id) { grade.id }
  let!(:board) { create(:board) }
  let(:board_id) { board.id }
  let!(:subjects) { create_list(:subject, 10, 
    grade_id: grade_id, board_id: board_id) }
  let(:subject_id) { subjects.first.id }
  before { student.grade_id = grade_id }
  before { student.board_id = board_id }

  # Test suite for GET /subjects
  describe 'GET /api/meta/subjects' do
    # make HTTP get request before each example
    before { login(student) }
    before { get '/api/meta/subjects' }

    it 'returns subjects' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /subjects/:id
  describe 'GET /api/meta/subjects/:id' do
    before { get "/api/meta/subjects/#{subject_id}" }

    context 'when the record exists' do
      it 'returns the subject' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(subject_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:subject_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Subject/)
      end
    end
  end

  # Test suite for POST /subjects
  describe 'POST /api/meta/subjects' do
    # valid payload
    let(:valid_attributes) { { subject_name: 'CBSE Class 11 Maths', board_id: board_id, grade_id: grade_id } }

    context 'when the request is valid' do
      before { post '/api/meta/subjects', params: valid_attributes }

      it 'creates a subject' do
        expect(json['subject_name']).to eq('CBSE Class 11 Maths')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/meta/subjects', params: { subject_name: 'CBSE Class 11 Maths', board_id: board_id } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/\b(?:Grade can't be blank|Grade is invalid)\b/)
      end
    end
  end

  # Test suite for PUT /subjects/:id
  describe 'PUT /api/meta/subjects/:id' do
    let(:valid_attributes) { { subject_name: 'CBSE Class 11 Mathematics' } }

    context 'when the record exists' do
      before { put "/api/meta/subjects/#{subject_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /subjects/:id
  describe 'DELETE /api/meta/subjects/:id' do
    before { delete "/api/meta/subjects/#{subject_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end