require 'rails_helper'

RSpec.describe StudentComplete, type: :model do
  it { should belong_to(:student) }
  it { should validate_presence_of(:student_id) }
  it { should validate_presence_of(:type_name) }
  it { should validate_presence_of(:type_id) }
end
