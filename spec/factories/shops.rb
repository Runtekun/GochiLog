FactoryBot.define do
  factory :shop do
    sequence(:name) { |n| "テスト店舗#{n}" }
    latitude { 35.6812 }
    longitude { 139.7671 }
  end
end
