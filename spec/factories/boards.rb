FactoryBot.define do
  factory :board do
    name { Faker::Name.unique.name }
    description { Faker::Name.unique.name }
  end
end
