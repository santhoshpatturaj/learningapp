class Note < ApplicationRecord
  belongs_to :student
  belongs_to :content
  validates_presence_of :note_text, :student_id
end
