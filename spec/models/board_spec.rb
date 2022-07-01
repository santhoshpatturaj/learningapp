require 'rails_helper'

RSpec.describe Board, type: :model do
  it { should have_many(:subjects).dependent(:destroy) }
  it { should have_many(:students) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
end
