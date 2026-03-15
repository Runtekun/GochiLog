class Review < ApplicationRecord
    belongs_to :user
    belongs_to :shop
    belongs_to :genre, optional: true
    has_one_attached :image
    has_many :likes, dependent: :destroy

    validates :body, presence: true
    validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

    def self.ransackable_attributes(auth_object = nil)
      [ "body", "created_at", "genre_id", "id", "rating", "shop_id", "updated_at", "user_id" ]
    end

    def self.ransackable_associations(auth_object = nil)
      [ "shop", "user", "genre" ]
    end
end
