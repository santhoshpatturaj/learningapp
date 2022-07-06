FactoryBot.define do
  factory :note do
    note_text { Faker::Quotes::Rajnikanth.joke }
  end
end
