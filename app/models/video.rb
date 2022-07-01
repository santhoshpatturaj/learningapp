class Video < ApplicationRecord

	validates_presence_of :title, :thumbnail, :duration, :link

end
