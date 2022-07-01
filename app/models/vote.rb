class Vote < ApplicationRecord
  belongs_to :student
  belongs_to :content
  validates_presence_of :upvote, :downvote, :student_id
end
