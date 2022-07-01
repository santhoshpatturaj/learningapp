require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:student).dependent(:destroy) }
  it { should belong_to(:content).dependent(:destroy) }
  it { should validate_presence_of(:upvote) }
  it { should validate_presence_of(:downvote) }
  it { should validate_presence_of(:student_id) }
end
