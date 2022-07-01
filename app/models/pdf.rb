class Pdf < ApplicationRecord
	validates_presence_of :title, :file
end
