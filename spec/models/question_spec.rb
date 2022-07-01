require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:exercise) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:option1) }
  it { should validate_presence_of(:option2) }
  it { should validate_presence_of(:option3) }
  it { should validate_presence_of(:option4) }
  it { should validate_presence_of(:correct_answer) }
  it { should validate_presence_of(:mark) }
end
