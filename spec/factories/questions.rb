FactoryBot.define do
  factory :question do
    text { Faker::Quotes::Rajnikanth.joke }
    option1 { Faker::DcComics.hero }
    option2 { Faker::DcComics.hero }
    option3 { Faker::DcComics.hero }
    option4 { Faker::DcComics.hero }
    correct_answer { Faker::Number.between(from: 1, to: 4) }
    mark { 1 }
  end
end
