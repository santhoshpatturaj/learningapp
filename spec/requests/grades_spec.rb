require 'rails_helper'

RSpec.describe 'Grades API', type: :request do
  # initialize test data
  let!(:grades) { create_list(:grade, 10) }
  let(:grade_id) { grades.first.id }

  # Test suite for GET /grades
  describe 'GET /api/meta/grades' do
    # make HTTP get request before each example
    before { get '/api/meta/grades' }

    it 'returns grades' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /grades/:id
  describe 'GET /api/meta/grades/:id' do
    before { get "/api/meta/grades/#{grade_id}" }

    context 'when the record exists' do
      it 'returns the grade' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(grade_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:grade_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Grade/)
      end
    end
  end

  # Test suite for POST /grades
  describe 'POST /api/meta/grades' do
    # valid payload
    let(:valid_attributes) { { title: 'CBSE class 11' } }

    context 'when the request is valid' do
      before { post '/api/meta/grades', params: valid_attributes }

      it 'creates a grade' do
        expect(json['title']).to eq('CBSE class 11')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/meta/grades', params: { } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /grades/:id
  describe 'PUT /api/meta/grades/:id' do
    let(:valid_attributes) { { title: 'CBSE class 12' } }

    context 'when the record exists' do
      before { put "/api/meta/grades/#{grade_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /grades/:id
  describe 'DELETE /api/meta/grades/:id' do
    before { delete "/api/meta/grades/#{grade_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end