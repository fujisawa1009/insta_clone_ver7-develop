# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  email            :string(255)      not null
#  salt             :string(255)
#  username         :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#like' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    it 'いいねできること' do
      expect { user.like(post) }.to change { Like.count }.by(1)
    end
  end

  describe '#unlike' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    before do
      user.like(post)
    end
    it 'いいねが解除できること' do
      expect { user.unlike(post) }.to change { Like.count }.by(-1)
    end
  end

  describe '#like?' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    let!(:not_liked_post) { create(:post) }
    before do
      user.like(post)
    end
    it 'いいねしてるかどうかを判定できること' do
      expect(user.like?(post)).to be true
      expect(user.like?(not_liked_post)).to be false
    end
  end

  describe '#follow' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    it 'フォローできること' do
      expect { user_a.follow(user_b) }.to change { Relationship.count }.by(1)
    end
  end

  describe '#unfollow' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    before do
      user_a.follow(user_b)
    end
    it 'フォローを外せること' do
      expect { user_a.unfollow(user_b) }.to change { Relationship.count }.by(-1)
    end
  end

  describe '#following?' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    context 'フォローしている場合' do
      before do
        user_a.follow(user_b)
      end
      it 'trueを返す' do
        expect(user_a.following?(user_b)).to be true
      end
    end

    context 'フォローしていない場合' do
      let!(:user_a) { create(:user) }
      let!(:user_b) { create(:user) }
      it 'falseを返す' do
        expect(user_a.following?(user_b)).to be false
      end
    end
  end
end
