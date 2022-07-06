FactoryBot.define do
  factory :exercise do
    title { Faker::Name.unique.name }
    no_of_questions { Faker::Number.number(digits: 2) }
    marks { Faker::Number.number(digits: 2) }
    duration { '00:45:00' }
  end
end
