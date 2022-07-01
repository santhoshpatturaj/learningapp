require 'rails_helper'

RSpec.describe Subject, type: :model do
  it { should belong_to(:board) }
  it { should belong_to(:grade) }
  it { should have_many(:chapters) }
  it { should validate_presence_of(:subject_name) }
  it { should validate_presence_of(:board_id) }
  it { should validate_presence_of(:grade_id) }
end
