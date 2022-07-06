require 'rails_helper'

RSpec.describe 'Students API', type: :request do
  # initialize test data
  let!(:student) { create(:student) }
  let(:student_id) { student.id }
  let!(:grade) { create(:grade) }
  let(:grade_id) { grade.id }
  let(:mobile) { student.mobile }
  let(:full_name) { student.full_name }


  # Test suite for GET /students
  describe 'GET /api/user_management/students' do
    # make HTTP get request before each example
    before { login(student) }
    before { get '/api/user_management/students' }

    it 'returns the student' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

    # Test suite for POST /auth/sign_up
  describe 'POST /api/user_management/auth/sign_up' do

    before  { Doorkeeper::Application.create(name: "Test client", redirect_uri: "", scopes: "") }
    let(:client_id) { Doorkeeper::Application.find_by(name: "Test client").uid }
    # valid payload
    let(:valid_attributes) { { full_name: 'Alex', 
      email: 'alex123@example.com',
      mobile: '9876543210',
      dob: '2007-10-10',
      client_id: client_id } }

    context 'when the request is valid' do
      before { post '/api/user_management/auth/sign_up', params: valid_attributes }

      it 'creates a student' do
        expect(json['full_name']).to eq('Alex')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/user_management/auth/sign_up', params: { full_name: 'Alex',
      dob: '2007-10-10',
      mobile: '9876543210',
      client_id: client_id } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/\b(?:Email can't be blank|Email is invalid)\b/)
      end
    end
  end

  # Test suite for POST /students/get_otp
  describe 'POST /api/user_management/students/get_otp' do
    let(:valid_attributes) { {
      mobile: mobile } }

    context 'when the request is valid' do
      before { post '/api/user_management/students/get_otp', params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end
    end
  end


  # Test suite for PUT /students/update
  describe 'PUT /api/user_management/students/update' do
    let(:valid_attributes) { { student_id: student_id, grade_id: grade_id } }

    before { login(student) }

    before { put "/api/user_management/students/update", params: valid_attributes }

    it 'updates the record' do
      expect(response.body).to be_empty
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

  end

end