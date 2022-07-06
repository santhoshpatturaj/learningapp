require 'rails_helper'

RSpec.describe 'Pdfs API', type: :request do
  # initialize test data
  let!(:pdfs) { create_list(:pdf, 10) }
  let(:pdf_id) { pdfs.first.id }

  # Test suite for GET /pdfs
  describe 'GET /api/content_management/pdfs' do
    # make HTTP get request before each example
    before { get '/api/content_management/pdfs' }

    it 'returns pdfs' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /pdfs/:id
  describe 'GET /api/content_management/pdfs/:id' do
    before { get "/api/content_management/pdfs/#{pdf_id}" }

    context 'when the record exists' do
      it 'returns the pdf' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(pdf_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:pdf_id) { 10 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Pdf/)
      end
    end
  end

  # Test suite for POST /pdfs
  describe 'POST /api/content_management/pdfs' do
    # valid payload
    let(:valid_attributes) { { title: 'Trigonometric ratios', file: 'trig_ratios.pdf' } }

    context 'when the request is valid' do
      before { post '/api/content_management/pdfs', params: valid_attributes }

      it 'creates a pdf' do
        expect(json['title']).to eq('Trigonometric ratios')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/content_management/pdfs', params: { title: 'Trigonometric ratios' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: File can't be blank/)
      end
    end
  end

  # Test suite for PUT /pdfs/:id
  describe 'PUT /api/content_management/pdfs/:id' do
    let(:valid_attributes) { { file: 'trig_ratios_updated.pdf' } }

    context 'when the record exists' do
      before { put "/api/content_management/pdfs/#{pdf_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /pdfs/:id
  describe 'DELETE /api/content_management/pdfs/:id' do
    before { delete "/api/content_management/pdfs/#{pdf_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end