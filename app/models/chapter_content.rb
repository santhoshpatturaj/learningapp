class ChapterContent < ApplicationRecord
  belongs_to :chapter
  belongs_to :content

  validates_presence_of :chapter_id, :content_id
  
end
