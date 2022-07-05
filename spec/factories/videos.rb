FactoryBot.define do
  factory :video do
    title { Faker::Name.unique.name }
    thumbnail { Faker::File.file_name(dir: 'path/to') }
    duration { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    link { "00:05:00" }
  end
end
