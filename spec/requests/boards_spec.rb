require 'rails_helper'

RSpec.describe 'Boards API', type: :request do
  # initialize test data
  let!(:boards) { create_list(:board, 10) }
  let(:board_id) { boards.first.id }

  # Test suite for GET /boards
  describe 'GET /api/meta/boards' do
    # make HTTP get request before each example
    before { get '/api/meta/boards' }

    it 'returns boards' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /boards/:id
  describe 'GET /api/meta/boards/:id' do
    before { get "/api/meta/boards/#{board_id}" }

    context 'when the record exists' do
      it 'returns the board' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(board_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:board_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Board/)
      end
    end
  end

  # Test suite for POST /boards
  describe 'POST /api/meta/boards' do
    # valid payload
    let(:valid_attributes) { { name: 'CBSE', description: 'Central Board of Secondary Education' } }

    context 'when the request is valid' do
      before { post '/api/meta/boards', params: valid_attributes }

      it 'creates a board' do
        expect(json['name']).to eq('CBSE')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/meta/boards', params: { name: 'CBSE' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /boards/:id
  describe 'PUT /api/meta/boards/:id' do
    let(:valid_attributes) { { description: 'CBSE' } }

    context 'when the record exists' do
      before { put "/api/meta/boards/#{board_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /boards/:id
  describe 'DELETE /api/meta/boards/:id' do
    before { delete "/api/meta/boards/#{board_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end