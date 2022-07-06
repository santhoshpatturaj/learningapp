FactoryBot.define do
  factory :chapter do
    chapter_name { Faker::Name.unique.name }
  end
end
