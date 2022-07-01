class Note < ApplicationRecord
  belongs_to :student, dependent: :destroy
  belongs_to :content, dependent: :destroy
  validates_presence_of :note_text, :student_id
end
