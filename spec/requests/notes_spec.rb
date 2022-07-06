require 'rails_helper'

RSpec.describe 'Notes API', type: :request do
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
  let!(:note1) { create(:note, content_id: content1.id, student_id: student_id) }
  let!(:note2) { create(:note, content_id: content2.id, student_id: student_id) }
  let(:note_id) { note1.id }

  # Test suite for GET /notes
  describe 'GET /api/content_management/notes' do
    before { login(student) }
    # make HTTP get request before each example
    before { get '/api/content_management/notes', params: { content_id: content_id, student_id: student_id } }

    it 'returns notes' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /notes/:id
  describe 'GET /api/content_management/notes/:id' do
    before { login(student) }
    before { get "/api/content_management/notes/#{note_id}" }

    context 'when the record exists' do
      it 'returns the note' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(note_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:note_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end

  # Test suite for POST /notes
  describe 'POST /api/content_management/notes' do
    # valid payload

    let(:valid_attributes) { { note_text: 'Trigonometric ratios: sin,cos,tan', content_id: content_id } }

    context 'when the request is valid' do
      before { login(student) }
      before { post '/api/content_management/notes', params: valid_attributes }

      it 'creates a note' do
        expect(json['note_text']).to eq('Trigonometric ratios: sin,cos,tan')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { login(student) }
      before { post '/api/content_management/notes', params: { note_text: 'Trigonometric ratios: sin,cos,tan' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Content must exist/)
      end
    end
  end

  # Test suite for PUT /notes/:id
  describe 'PUT /api/content_management/notes/:id' do
    let(:valid_attributes) { { content_id: content2_id } }

    context 'when the record exists' do
      before { login(student) }
      before { put "/api/content_management/notes/#{note_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /notes/:id
  describe 'DELETE /api/content_management/notes/:id' do
    before { login(student) }
    before { delete "/api/content_management/notes/#{note_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end