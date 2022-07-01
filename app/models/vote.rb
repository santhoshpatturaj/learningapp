class Vote < ApplicationRecord
  belongs_to :student, dependent: :destroy
  belongs_to :content, dependent: :destroy
  validates_presence_of :upvote, :downvote, :student_id
end
