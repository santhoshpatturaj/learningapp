require 'rails_helper'

RSpec.describe Content, type: :model do
  it { should validate_presence_of(:sno) }
  it { should validate_presence_of(:type_name) }
end
