require 'rails_helper'

RSpec.describe 'Chapters API', type: :request do
  # initialize test data
  let!(:grade) { create(:grade) }
  let(:grade_id) { grade.id }
  let!(:board) { create(:board) }
  let(:board_id) { board.id }
  let!(:subject) { create(:subject, grade_id: grade_id, board_id: board_id) }
  let(:subject_id) { subject.id }
  let!(:chapters) { create_list(:chapter, 10, subject_id: subject_id) }
  let(:chapter_id) { chapters.first.id }

  # Test suite for GET /chapters
  describe 'GET /api/meta/chapters' do
    # make HTTP get request before each example
    before { get '/api/meta/chapters', params: { subject_id: subject_id} }

    it 'returns chapters' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /chapters/:id
  describe 'GET /api/meta/chapters/:id' do
    before { get "/api/meta/chapters/#{chapter_id}" }

    context 'when the record exists' do
      it 'returns the chapter' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(chapter_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:chapter_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Chapter/)
      end
    end
  end

  # Test suite for POST /chapters
  describe 'POST /api/meta/chapters' do
    # valid payload
    let(:valid_attributes) { { chapter_name: 'Trigonometric ratios', subject_id: subject_id } }

    context 'when the request is valid' do
      before { post '/api/meta/chapters', params: valid_attributes }

      it 'creates a chapter' do
        expect(json['chapter_name']).to eq('Trigonometric ratios')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/meta/chapters', params: { chapter_name: 'Trigonometric ratios' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Subject must exist/)
      end
    end
  end

  # Test suite for PUT /chapters/:id
  describe 'PUT /api/meta/chapters/:id' do
    let(:valid_attributes) { { chapter_name: 'Trigonometric Functions' } }

    context 'when the record exists' do
      before { put "/api/meta/chapters/#{chapter_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /chapters/:id
  describe 'DELETE /api/meta/chapters/:id' do
    before { delete "/api/meta/chapters/#{chapter_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end