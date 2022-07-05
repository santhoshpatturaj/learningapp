require 'rails_helper'

RSpec.describe 'Videos API', type: :request do
  # initialize test data
  let!(:videos) { create_list(:video, 10) }
  let(:video_id) { videos.first.id }

  # Test suite for GET /videos
  describe 'GET /api/content_management/videos' do
    # make HTTP get request before each example
    before { get '/api/content_management/videos' }

    it 'returns videos' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /videos/:id
  describe 'GET /api/content_management/videos/:id' do
    before { get "/api/content_management/videos/#{video_id}" }

    context 'when the record exists' do
      it 'returns the video' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(video_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:video_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Video/)
      end
    end
  end

  # Test suite for POST /videos
  describe 'POST /api/content_management/videos' do
    # valid payload
    let(:valid_attributes) { { title: 'Trigonometric ratios', thumbnail: 'trig_ratios.jpg', link: 'www.trigvideos/trig_ratios.mp4', duration: '00:03:00' } }

    context 'when the request is valid' do
      before { post '/api/content_management/videos', params: valid_attributes }

      it 'creates a video' do
        expect(json['title']).to eq('Trigonometric ratios')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/content_management/videos', params: { title: 'Trigonometric ratios', thumbnail: 'trig_ratios.jpg', link: 'www.trigvideos/trig_ratios.mp4' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Duration can't be blank/)
      end
    end
  end

  # Test suite for PUT /videos/:id
  describe 'PUT /api/content_management/videos/:id' do
    let(:valid_attributes) { { file: 'www.trigvideos/trig_ratios_updated.mp4' } }

    context 'when the record exists' do
      before { put "/api/content_management/videos/#{video_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /videos/:id
  describe 'DELETE /api/content_management/videos/:id' do
    before { delete "/api/content_management/videos/#{video_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end