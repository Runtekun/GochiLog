class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, length: { maximum: 30 }, presence: true, uniqueness: true
  validates :email, length: { maximum: 255 }, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, presence: true
end
