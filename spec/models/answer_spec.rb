require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:attempt) }
  it { should belong_to(:question) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:attempt_id) }
  it { should validate_presence_of(:question_id) }
end
