class Shop < ApplicationRecord
    has_many :reviews, dependent: :destroy

    validates :name, presence: true
    validates :latitude, presence: true
    validates :longitude, presence: true

    def self.ransackable_attributes(auth_object = nil)
      [ "id", "name", "latitude", "longitude", "created_at", "updated_at" ]
    end
end
