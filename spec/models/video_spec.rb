require 'rails_helper'

RSpec.describe Video, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:thumbnail) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:link) }
end
