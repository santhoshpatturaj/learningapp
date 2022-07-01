class Chapter < ApplicationRecord
	belongs_to :subject
	has_many :chapter_contents, dependent: :destroy

	validates_presence_of :chapter_name
end
