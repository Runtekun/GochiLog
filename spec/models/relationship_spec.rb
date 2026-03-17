require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "バリデーション" do
    it "有効なフォロー関係は保存できる" do
      relationship = build(:relationship)
      expect(relationship).to be_valid
    end

    it "同じユーザーを2回フォローできない" do
      follower = create(:user)
      followed = create(:user)
      create(:relationship, follower: follower, followed: followed)
      duplicate = build(:relationship, follower: follower, followed: followed)
      expect(duplicate).not_to be_valid
    end
  end
end
