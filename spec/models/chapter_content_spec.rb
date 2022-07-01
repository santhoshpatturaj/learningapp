require 'rails_helper'

RSpec.describe ChapterContent, type: :model do
  it {should belong_to(:chapter) }
  it {should belong_to(:content) }
end
