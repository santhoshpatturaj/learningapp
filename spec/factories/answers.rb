FactoryBot.define do
  factory :answer do
    option { Faker::Number.between(from: 1, to: 4) }
  end
end
