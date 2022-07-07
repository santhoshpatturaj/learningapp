require 'rails_helper'

RSpec.describe 'Votes API', type: :request do
  # initialize test data
  let!(:student) { create(:student) }
  let(:student_id) { student.id }
  let!(:pdf) { create(:pdf) }
  let(:pdf_id) { pdf.id }
  let!(:video) { create(:video) }
  let(:video_id) { video.id }
  let!(:content1) { create(:content, type_name: 'pdf', type_id: pdf_id) }
  let!(:content2) { create(:content, type_name: 'video', type_id: video_id) }
  let(:content_id) { content1.id }
  let(:content2_id) { content2.id }
  let!(:vote1) { create(:vote, content_id: content_id, student_id: student_id, upvote: false, downvote: true ) }
  let(:vote_id) { vote1.id }

  # Test suite for GET /votes
  describe 'GET /api/content_management/votes' do
    before { login(student) }
    # make HTTP get request before each example
    before { get '/api/content_management/votes', params: { content_id: content_id} }

    it 'returns votes' do
      # Vote `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /votes/:id
  describe 'GET /api/content_management/votes/:id' do
    before { login(student) }
    before { get "/api/content_management/votes/#{vote_id}" }

    context 'when the record exists' do
      it 'returns the vote' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(vote_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:vote_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Vote/)
      end
    end
  end

  # Test suite for POST /votes
  describe 'POST /api/content_management/votes' do
    # valid payload

    let(:valid_attributes) { { content_id: content2_id, upvote: false, downvote: true } }

    context 'when the request is valid' do
      before { login(student) }
      before { post '/api/content_management/votes', params: valid_attributes }

      it 'creates a vote' do
        expect(json['downvote']).to eq(true)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { login(student) }
      before { post '/api/content_management/votes', params: { upvote: true, downvote: false } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Content must exist/)
      end
    end
  end

  # Test suite for PUT /votes/:id
  describe 'PUT /api/content_management/votes/:id' do
    let(:valid_attributes) { { downvote: true, upvote: false } }

    context 'when the record exists' do
      before { login(student) }
      before { put "/api/content_management/votes/#{vote_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /votes/:id
  describe 'DELETE /api/content_management/votes/:id' do
    before { login(student) }
    before { delete "/api/content_management/votes/#{vote_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end