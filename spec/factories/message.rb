FactoryBot.define do
  factory :message do
    comment {Faker::Lorem.sentence}
    association :user
    association :room
  end
end