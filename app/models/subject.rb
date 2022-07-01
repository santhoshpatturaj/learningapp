class Subject < ApplicationRecord

	belongs_to :board
	belongs_to :grade
	has_many :chapters
	
	validates_presence_of :subject_name
	
end
