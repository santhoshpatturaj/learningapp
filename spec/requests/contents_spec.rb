require 'rails_helper'

RSpec.describe 'Contents API', type: :request do
  # initialize test data
  let!(:pdf) { create(:pdf) }
  let(:pdf_id) { pdf.id }
  let!(:pdf2) { create(:pdf) }
  let(:pdf2_id) { pdf2.id }
  let!(:video) { create(:video) }
  let(:video_id) { video.id }
  let!(:exercise) { create(:exercise) }
  let(:exercise_id) { exercise.id }
  let!(:content1) { create(:content, type_name: 'pdf', type_id: pdf_id) }
  let!(:content2) { create(:content, type_name: 'video', type_id: video_id) }
  let!(:content3) { create(:content, type_name: 'exercise', type_id: exercise_id) }
  let(:content_id) { content1.id }

  # Test suite for GET /contents
  describe 'GET /api/content_management/contents' do
    # make HTTP get request before each example
    before { get '/api/content_management/contents' }

    it 'returns contents' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /contents/:id
  describe 'GET /api/content_management/contents/:id' do
    before { get "/api/content_management/contents/#{content_id}" }

    context 'when the record exists' do
      it 'returns the content' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(content_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:content_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Content/)
      end
    end
  end

  # Test suite for POST /contents
  describe 'POST /api/content_management/contents' do
    # valid payload 
    let(:valid_attributes) { { sno: 100, type_name: 'pdf', type_id: pdf2_id } }

    context 'when the request is valid' do
      before { post '/api/content_management/contents', params: valid_attributes }

      it 'creates a content' do
        expect(json['sno']).to eq(100)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/content_management/contents', params: { } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Sno can't be blank/)
      end
    end
  end

  # Test suite for PUT /contents/:id
  describe 'PUT /api/content_management/contents/:id' do
    let(:valid_attributes) { { type_id: pdf_id } }

    context 'when the record exists' do
      before { put "/api/content_management/contents/#{content_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /contents/:id
  describe 'DELETE /api/content_management/contents/:id' do
    before { delete "/api/content_management/contents/#{content_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end