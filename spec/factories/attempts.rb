FactoryBot.define do
  factory :attempt do
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    end_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    score { Faker::Number.between(from: 0, to: 100) }
    pass { Faker::Boolean.boolean }
  end
end
