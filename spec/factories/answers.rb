FactoryBot.define do
  factory :answer do
    attempt { nil }
    question { nil }
    option { "MyString" }
  end
end
