FactoryBot.define do
  factory :review do
    body { "おいしかったです。" }
    rating { 4 }
    association :user
    association :shop
  end
end
