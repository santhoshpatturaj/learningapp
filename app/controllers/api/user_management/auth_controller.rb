class Api::UserManagement::AuthController < Api::ApplicationController
	skip_before_action :doorkeeper_authorize!, only: [:signup, :login]
	before_action :validate_user!, only: [:logout, :view]

	def logout
		doorkeeper_token.destroy
	end

	def view
		render json: current_user, status: :ok
	end

  def signup
      ActiveRecord::Base.transaction do

			user = Student.where(mobile: signup_params[:mobile]).first
            throw_error('A User with the given mobile number already exists', :unprocessable_entity) if user.present?
           
      @otp = gen_otp

			@expiry = Time.now() + (10*60)

			puts "OTP: #{@otp} Expiry: #{@expiry}"

			client_app = Doorkeeper::Application.find_by(uid: signup_params[:client_id])

			return render(json: { error: 'Invalid client ID'}, status: 403) unless client_app

			user = Student.new(email: signup_params[:email], password: @otp, otp_timestamp: @expiry, mobile: signup_params[:mobile], full_name: signup_params[:full_name], dob: signup_params[:dob])

      if user.save

			access_token = Doorkeeper::AccessToken.create(
				application_id: client_app.id,
					resource_owner_id: user.id,
					refresh_token: generate_refresh_token,
					expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
					scopes: 'user'
			)

			token = {
				access_token: access_token.token,
				token_type: 'bearer',
				expires_in: access_token.expires_in,
				refresh_token: access_token.refresh_token,
				created_at: access_token.created_at
			}

      render json: { user: user, otp: @otp, token: token } , status: :created

      else
        render(json: { error: user.errors.full_messages }, status: 422)
      end

		end
	end

	def login
		if user_params[:grant_type] == "password"

			throw_error("Mobile or OTP is missing.", :unprocessable_entity) if user_params[:mobile].blank? or user_params[:password].blank?
			client_app = Doorkeeper::Application.find_by(uid: user_params[:client_id])

			return render(json: { error: 'Invalid client ID'}, status: 403) unless client_app

			student = Student.find_for_authentication(mobile: user_params[:mobile])
			expiry = student.otp_timestamp
    		@user = ((student&.valid_password?(user_params[:password])) and (Time.now() < expiry)) ? student : nil

			throw_error("Mobile or OTP is incorrect.", :unprocessable_entity) if @user.blank?

			access_token = Doorkeeper::AccessToken.create(
				application_id: client_app.id,
				resource_owner_id: @user.id,
				refresh_token: generate_refresh_token,
				expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
				scopes: 'user'
			)

			token = {
				access_token: access_token.token,
				token_type: 'bearer',
				expires_in: access_token.expires_in,
				refresh_token: access_token.refresh_token,
				created_at: access_token.created_at
			}

			render json: { user: @user, token: token } , status: :created

		elsif user_params[:grant_type] == "refresh_token"
			client_app = Doorkeeper::Application.find_by(uid: user_params[:client_id])

			return render(json: { error: 'Invalid client ID'}, status: 403) unless client_app

			throw_error("Refresh Token is missing.", :unprocessable_entity) if user_params[:refresh_token].blank? 

			access_token = Doorkeeper::AccessToken.find_by(refresh_token: user_params[:refresh_token])
			@user = Student.find_by(id: access_token.resource_owner_id)

			throw_error("Token is not valid!.", 401) if @user.blank?

			access_token.destroy

			new_token = Doorkeeper::AccessToken.create(
				application_id: client_app.id,
			   resource_owner_id: @user.id,
			   refresh_token: user_params[:refresh_token],
			   expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
			   scopes: 'user'
			)

			token =  {
				access_token: new_token.token,
				token_type: 'bearer',
				expires_in: new_token.expires_in,
				refresh_token: new_token.refresh_token,
				created_at: new_token.created_at
			}

			render json: { user: user, token: token } , status: :created
		end
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
		params.permit(:mobile, :password, :client_id, :client_secret, :refresh_token, :grant_type)
	end

    def signup_params
		params.permit(:email, :mobile, :dob, :full_name, :client_id)
	end

	def gen_otp
      charset = Array('0'..'9')
      Array.new(4) { charset.sample }.join
    end

  def generate_refresh_token
    loop do
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end 

end