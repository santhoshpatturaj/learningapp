FactoryBot.define do
  factory :grade do
    title { Faker::Name.unique.name }
  end
end
