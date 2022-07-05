FactoryBot.define do
  factory :pdf do
    title { Faker::Name.unique.name }
    file { Faker::File.file_name(dir: 'path/to')}
  end
end
