module User_management
  class Api::UserManagement::StudentsController < Api::ApplicationController
    skip_before_action :doorkeeper_authorize!, only: [:create, :get_otp]
    before_action :set_student, only: [:update, :index]

    def index
      json_response(@student)
    end

    def create
      @otp = gen_otp

      @expiry = Time.now() + (10*60)

      puts "OTP: #{@otp} Expiry: #{@expiry}"

      user = Student.new(email: user_params[:email], password: @otp, otp_timestamp: @expiry, mobile: user_params[:mobile], full_name: user_params[:full_name], dob: user_params[:dob])

      client_app = Doorkeeper::Application.find_by(uid: params[:client_id])

      return render(json: { error: 'Invalid client ID'}, status: 403) unless client_app

      if user.save
        json_response(user, :created)
      else
        render(json: { error: user.errors.full_messages }, status: 422)
      end
    end

    def update
      @student.update(choose_params)
      head :no_content
    end

    def get_otp
      user = Student.find_by mobile: user_params[:mobile]
      @otp = gen_otp
      @expiry = Time.now() + (2*60)
      puts "OTP: #{@otp} Expiry: #{@expiry}"
      user.update(password: @otp, otp_timestamp: @expiry)
      head :no_content
    end

    private

    def user_params
      params.permit(:email, :mobile, :dob, :full_name, :client_id)
    end

    def choose_params
      params.permit(:board_id, :grade_id, :profile_photo, :email, :dob)
    end

    def generate_refresh_token
      loop do
        token = SecureRandom.hex(32)
        break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
      end
    end 

    def set_student
      @student = current_user
    end

    def gen_otp
      charset = Array('0'..'9')
      Array.new(4) { charset.sample }.join
    end

  end
end