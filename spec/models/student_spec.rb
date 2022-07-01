require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:notes).dependent(:destroy) }
  it { should have_many(:attempts).dependent(:destroy) }
  it { should have_many(:student_completes).dependent(:destroy) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:mobile) }
  it { should validate_presence_of(:dob) }
  it { should validate_presence_of(:email) }
end
