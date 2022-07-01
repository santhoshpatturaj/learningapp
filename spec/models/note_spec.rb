require 'rails_helper'

RSpec.describe Note, type: :model do
  it { should belong_to(:student).dependent(:destroy) }
  it { should belong_to(:content).dependent(:destroy) }
  it { should validate_presence_of(:student_id) }
  it { should validate_presence_of(:note_text) }
end
