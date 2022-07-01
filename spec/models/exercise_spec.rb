require 'rails_helper'

RSpec.describe Exercise, type: :model do
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:attempts).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:no_of_questions) }
  it { should validate_presence_of(:marks) }
  it { should validate_presence_of(:duration) }
end
