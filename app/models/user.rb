class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_one_attached :avatar

  validates :name, length: { maximum: 30 }, presence: true, uniqueness: true
  validates :email, length: { maximum: 255 }, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, presence: true
  validates :bio, length: { maximum: 500 }, allow_blank: true
end
