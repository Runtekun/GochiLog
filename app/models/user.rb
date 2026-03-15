class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_one_attached :avatar

  validates :name, length: { maximum: 30 }, presence: true, uniqueness: true
  validates :email, length: { maximum: 255 }, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, presence: true, if: :password_required?
  validates :bio, length: { maximum: 500 }, allow_blank: true

  # フォロー機能のメソッド
  def follow(other_user)
    active_relationships.create(followed: other_user)
  end

  # フォロー解除機能のメソッド
  def unfollow(other_user)
    active_relationships.find_by(followed: other_user)&.destroy
  end

  # フォローしているかどうかを判断するメソッド
  def following?(other_user)
    following.include?(other_user)
  end

  # Ransackで検索可能な属性を指定するメソッド
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "created_at", "updated_at" ]
  end

  # ユーザーがプロフィールを更新する際に、現在のパスワードを要求するかどうかを判断するメソッド
  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
