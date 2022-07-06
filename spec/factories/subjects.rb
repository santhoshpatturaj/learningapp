FactoryBot.define do
  factory :subject do
    subject_name { Faker::Name.unique.name }
  end
end
