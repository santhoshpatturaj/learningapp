class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	has_many :votes, dependent: :destroy
	has_many :attempts, dependent: :destroy
	has_many :notes, dependent: :destroy
	has_many :student_completes, dependent: :destroy

	validates_presence_of :full_name, :mobile, :dob
	validates :mobile, uniqueness: true
	validates :email, format: URI::MailTo::EMAIL_REGEXP

	def self.authenticate(mobile, password)
    user = Student.find_for_authentication(mobile: mobile)
    expiry = user.otp_timestamp
    ((user&.valid_password?(password)) and (Time.now() < expiry)) ? user : nil
  end
end
