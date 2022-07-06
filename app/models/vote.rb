class Vote < ApplicationRecord
  belongs_to :student, dependent: :destroy
  belongs_to :content, dependent: :destroy
  validates_presence_of :student_id
  validates :upvote, :inclusion => [true, false]
  validates :downvote, :inclusion => [true, false]
  validates_uniqueness_of :student_id, :scope => [:content_id]
end
