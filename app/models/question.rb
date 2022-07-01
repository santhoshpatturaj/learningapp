class Question < ApplicationRecord
	
	belongs_to :exercise
	has_many :responses, dependent: :destroy

	validates_presence_of :text, :option1, :option2, :option3, :option4, :correct_answer, :mark

end
