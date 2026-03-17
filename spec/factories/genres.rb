FactoryBot.define do
  factory :genre do
    sequence(:name) { |n| "ジャンル#{n}" }
  end
end
