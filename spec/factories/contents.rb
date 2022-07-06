FactoryBot.define do
  factory :content do
    sno { Faker::Number.number(digits: 3) }
  end
end
