require 'rails_helper'

RSpec.describe Chapter, type: :model do
  it { should belong_to(:subject) }
  it { should have_many(:chapter_contents).dependent(:destroy) }
  it { should validate_presence_of(:chapter_name) }
end
