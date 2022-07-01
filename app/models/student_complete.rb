class StudentComplete < ApplicationRecord
  belongs_to :student
  enum :type_name, { content: 0, chapter: 1, subject: 2 }
  validates_presence_of :student_id, :type_name, :type_id
end
