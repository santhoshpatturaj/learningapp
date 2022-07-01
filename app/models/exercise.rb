class Exercise < ApplicationRecord

	has_many :questions, dependent: :destroy
	has_many :attempts, dependent: :destroy

	validates_presence_of :title, :no_of_questions, :marks, :duration
end
