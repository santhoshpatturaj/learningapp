class Content < ApplicationRecord
	enum :type_name, { pdf: 0, video: 1, exercise: 2}
	validates_presence_of :sno, :type_name
end
