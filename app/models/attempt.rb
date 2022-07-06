class Attempt < ApplicationRecord
	belongs_to :student
	belongs_to :exercise

	validates_presence_of :start_time, :score
	validates :pass, :inclusion => [true, false]
end
