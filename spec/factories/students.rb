FactoryBot.define do
  factory :student do

    full_name { Faker::Name.unique.name }
    mobile { Faker::PhoneNumber.cell_phone_in_e164 }
    email { Faker::Internet.safe_email }
    dob { Faker::Date.birthday(min_age: 5, max_age: 100) }
    profile_photo { Faker::File.file_name(dir: 'path/to') }
    board_id { nil }
    grade_id { nil }
    password { Faker::Number.number(digits: 4) }

  end
end
