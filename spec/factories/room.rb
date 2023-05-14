FactoryBot.define do
  factory :room do
    name {Faker::Team.name}
    association :topic
  end
end