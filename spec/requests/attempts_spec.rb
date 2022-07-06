require 'rails_helper'

RSpec.describe 'Attempts API', type: :request do
  # initialize test data
  let!(:student) { create(:student) }
  let(:student_id) { student.id }
  let!(:exercise) { create(:exercise) }
  let(:exercise_id) { exercise.id }
  let!(:attempts) { create_list(:attempt, 10, exercise_id: exercise_id, student_id: student_id) }
  let(:attempt_id) { attempts.first.id }

  # Test suite for GET /attempts
  describe 'GET /api/exercise_management/attempts' do
    # make HTTP get request before each example
    before { login(student) }
    before { get '/api/exercise_management/attempts', params: { exercise_id: exercise_id} }

    it 'returns attempts' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /attempts/:id
  describe 'GET /api/exercise_management/attempts/:id' do
    before { login(student) }
    before { get "/api/exercise_management/attempts/#{attempt_id}" }

    context 'when the record exists' do
      it 'returns the attempt' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(attempt_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:attempt_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Attempt/)
      end
    end
  end

  # Test suite for POST /attempts
  describe 'POST /api/exercise_management/attempts' do
    # valid payload
    let(:valid_attributes) { { 
      start_time: '2021-09-18 12:30:59 -0700',
      end_time: '2021-09-18 12:59:59 -0700',
      score: 35,
      pass: true,
      exercise_id: exercise_id
    } }

    context 'when the request is valid' do
      before { login(student) }
      before { post '/api/exercise_management/attempts', params: valid_attributes }

      it 'creates a attempt' do
        expect(json['score']).to eq(35)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { login(student) }
      before { post '/api/exercise_management/attempts', params: { 
        start_time: '2021-09-18 12:30:59 -0700',
        end_time: '2021-09-18 12:59:59 -0700',
        pass: true,
        exercise_id: exercise_id
      } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Score can't be blank/)
      end
    end
  end

  # Test suite for PUT /attempts/:id
  describe 'PUT /api/exercise_management/attempts/:id' do
    let(:valid_attributes) { { score: 45 } }

    context 'when the record exists' do
      before { login(student) }
      before { put "/api/exercise_management/attempts/#{attempt_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /attempts/:id
  describe 'DELETE /api/exercise_management/attempts/:id' do
    before { login(student) }
    before { delete "/api/exercise_management/attempts/#{attempt_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end