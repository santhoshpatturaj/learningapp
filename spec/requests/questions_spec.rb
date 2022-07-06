require 'rails_helper'

RSpec.describe 'Questions API', type: :request do
  # initialize test data
  let!(:exercise) { create(:exercise) }
  let(:exercise_id) { exercise.id }
  let!(:questions) { create_list(:question, 10, exercise_id: exercise_id) }
  let(:question_id) { questions.first.id }

  # Test suite for GET /questions
  describe 'GET /api/exercise_management/questions' do
    # make HTTP get request before each example
    before { get '/api/exercise_management/questions', params: { exercise_id: exercise_id} }

    it 'returns questions' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /questions/:id
  describe 'GET /api/exercise_management/questions/:id' do
    before { get "/api/exercise_management/questions/#{question_id}" }

    context 'when the record exists' do
      it 'returns the question' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(question_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:question_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Question/)
      end
    end
  end

  # Test suite for POST /questions
  describe 'POST /api/exercise_management/questions' do
    # valid payload
    let(:valid_attributes) { { 
      text: 'Sample question',
      option1: 'option1',
      option2: 'option2',
      option3: 'option3',
      option4: 'option4',
      correct_answer: 4,
      mark: 2,
      exercise_id: exercise_id
    } }

    context 'when the request is valid' do
      before { post '/api/exercise_management/questions', params: valid_attributes }

      it 'creates a question' do
        expect(json['text']).to eq('Sample question')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/exercise_management/questions', params: { 
        option1: 'option1',
        option2: 'option2',
        option3: 'option3',
        option4: 'option4',
        correct_answer: 4,
        mark: 2,
        exercise_id: exercise_id
      } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Text can't be blank/)
      end
    end
  end

  # Test suite for PUT /questions/:id
  describe 'PUT /api/exercise_management/questions/:id' do
    let(:valid_attributes) { { correct_answer: 3 } }

    context 'when the record exists' do
      before { put "/api/exercise_management/questions/#{question_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /questions/:id
  describe 'DELETE /api/exercise_management/questions/:id' do
    before { delete "/api/exercise_management/questions/#{question_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end