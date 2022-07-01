require 'rails_helper'

RSpec.describe Attempt, type: :model do
  it { should belong_to(:student) }
  it { should belong_to(:exercise) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:score) }
  it { should validate_presence_of(:pass) }
end
