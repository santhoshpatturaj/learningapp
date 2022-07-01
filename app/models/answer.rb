class Answer < ApplicationRecord
  belongs_to :attempt
  belongs_to :question
  validates_presence_of :status, :attempt_id, :question_id
  enum :status, { not_answered: 0, answered: 1, marked: 2}
end
