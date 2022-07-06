require 'rails_helper'

RSpec.describe 'Answers API', type: :request do
  # initialize test data
  let!(:student) { create(:student) }
  let(:student_id) { student.id }
  let!(:exercise) { create(:exercise) }
  let(:exercise_id) { exercise.id }

  let!(:question1) { create(:question, exercise_id: exercise_id) }
  let(:question1_id) { question1.id }
  let!(:question2) { create(:question, exercise_id: exercise_id) }
  let(:question2_id) { question2.id }

  let!(:attempt) { create(:attempt, exercise_id: exercise_id, student_id: student_id) }
  let(:attempt_id) { attempt.id }

  let!(:answer1) { create(:answer, attempt_id: attempt_id, 
    question_id: question1_id, 
    option: 2,
    status: 'answered'
    ) }
  let(:answer_id) { answer1.id }


  # Test suite for GET /answers
  describe 'GET /api/exercise_management/answers' do
    # make HTTP get request before each example
    before { login(student) }
    before { get '/api/exercise_management/answers', params: { attempt_id: attempt_id } }

    it 'returns answers' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /answers/:id
  describe 'GET /api/exercise_management/answers/:id' do
    before { login(student) }
    before { get "/api/exercise_management/answers/#{answer_id}" }

    context 'when the record exists' do
      it 'returns the answer' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(answer_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:answer_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Answer/)
      end
    end
  end

  # Test suite for POST /answers
  describe 'POST /api/exercise_management/answers' do
    # valid payload
    let(:valid_attributes) { { 
      attempt_id: attempt_id, 
      question_id: question2_id, 
      option: 0,
      status: 'not_answered'
    } }

    context 'when the request is valid' do
      before { login(student) }
      before { post '/api/exercise_management/answers', params: valid_attributes }

      it 'creates a answer' do
        expect(json['status']).to eq('not_answered')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { login(student) }
      before { post '/api/exercise_management/answers', params: { 
        attempt_id: attempt_id, 
        question_id: question2_id, 
        status: 'not_answered'
      } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Option can't be blank/)
      end
    end
  end

  # Test suite for PUT /answers/:id
  describe 'PUT /api/exercise_management/answers/:id' do
    let(:valid_attributes) { { status: 'marked' } }

    context 'when the record exists' do
      before { login(student) }
      before { put "/api/exercise_management/answers/#{answer_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /answers/:id
  describe 'DELETE /api/exercise_management/answers/:id' do
    before { delete "/api/exercise_management/answers/#{answer_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  describe 'POST /api/exercise_management/get_result' do
    before { login(student) }
    before { post '/api/exercise_management/get_result', params: { attempt_id: attempt_id } }
    it 'returns score' do
      expect(json).not_to be_empty
      expect(json['attempt_id'].to_i).to eq(attempt_id)
    end
  end

end