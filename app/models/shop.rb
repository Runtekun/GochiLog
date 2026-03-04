class Shop < ApplicationRecord
    has_many :reviews, dependent: :destroy

    validates :name, presence: true
    validates :latitude, presence: true
    validates :longitude, presence: true
end
