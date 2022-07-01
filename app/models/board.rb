class Board < ApplicationRecord

	has_many :subjects, dependent: :destroy
	has_many :students

	validates_presence_of :name, :description
end
