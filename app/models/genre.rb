class Genre < ApplicationRecord
  has_many :reviews
  validates :name, presence: true, uniqueness: true

  # Ransackで検索可能な属性を指定するメソッド
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "created_at", "updated_at" ]
  end
end
