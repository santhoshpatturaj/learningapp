require 'rails_helper'

RSpec.describe 'ChapterContents API', type: :request do
  # initialize test data
  let!(:pdf) { create(:pdf) }
  let(:pdf_id) { pdf.id }
  let!(:content) { create(:content, type_name: 'pdf', type_id: pdf_id) }
  let(:content_id) { content.id }
  let!(:grade) { create(:grade) }
  let(:grade_id) { grade.id }
  let!(:board) { create(:board) }
  let(:board_id) { board.id }
  let!(:subject) { create(:subject, grade_id: grade_id, board_id: board_id) }
  let(:subject_id) { subject.id }
  let!(:chapter) { create(:chapter, subject_id: subject_id) }
  let(:chapter_id) { chapter.id }
  let!(:chapter_contents) { create_list(:chapter_content, 10, chapter_id: chapter_id, content_id: content_id) }
  let(:chapter_content_id) { chapter_contents.first.id }

  # Test suite for GET /chapter_contents
  describe 'GET /api/content_management/chapter_contents' do
    # make HTTP get request before each example
    before { get '/api/content_management/chapter_contents' }

    it 'returns chapter_contents' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /chapter_contents/:id
  describe 'GET /api/content_management/chapter_contents/:id' do
    before { get "/api/content_management/chapter_contents/#{chapter_content_id}" }

    context 'when the record exists' do
      it 'returns the chapter_content' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(chapter_content_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:chapter_content_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find ChapterContent/)
      end
    end
  end

  # Test suite for POST /chapter_contents
  describe 'POST /api/content_management/chapter_contents' do
    # valid payload
    let(:valid_attributes) { { chapter_id: chapter_id, content_id: content_id } }

    context 'when the request is valid' do
      before { post '/api/content_management/chapter_contents', params: valid_attributes }

      it 'creates a chapter_content' do
        expect(json['chapter_id']).to eq(chapter_id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/content_management/chapter_contents', params: { chapter_id: chapter_id } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Content must exist/)
      end
    end
  end

  # Test suite for PUT /chapter_contents/:id
  describe 'PUT /api/content_management/chapter_contents/:id' do
    let(:valid_attributes) { { content_id: content_id } }

    context 'when the record exists' do
      before { put "/api/content_management/chapter_contents/#{chapter_content_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /chapter_contents/:id
  describe 'DELETE /api/content_management/chapter_contents/:id' do
    before { delete "/api/content_management/chapter_contents/#{chapter_content_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end