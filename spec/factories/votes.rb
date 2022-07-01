FactoryBot.define do
  factory :vote do
    student { nil }
    content { nil }
    upvote { false }
    downvote { false }
  end
end
