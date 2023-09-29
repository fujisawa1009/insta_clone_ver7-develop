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
class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  has_many :active_relationships, class_name: 'Relationship',
                                  inverse_of: :follower,
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   inverse_of: :followed,
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :user_notifications, dependent: :destroy
  has_many :notifications, through: :user_notifications
  has_many :user_notification_timings, dependent: :destroy
  has_many :notification_timings, through: :user_notification_timings
  has_one_attached :avatar

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }

  scope :recent, ->(count = 10) { order(created_at: :desc).limit(count) }

  def owner?(object)
    object.user_id == id
  end

  def like(post)
    like_posts << post
  rescue ActiveRecord::RecordInvalid
    false
  end

  def unlike(post)
    like_posts.destroy(post)
  end

  def like?(post)
    like_posts.include?(post)
  end

  def follow(other_user)
    following << other_user
  rescue ActiveRecord::RecordInvalid
    false
  end

  def unfollow(other_user)
    following.destroy(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    Post.where(user_id: following_ids << id)
  end

  # ransackの4系からモデルに許可リストが必要
  def self.ransackable_attributes(_auth_object = nil)
    ['username']
  end

  def accepted_notification?(type)
    notification_timings.find_by(timing_type: type).present?
    # こちらでも良い
    # user_notification_timings.joins(:notification_timing).find_by(notification_timing: { timing_type: type }).present?
  end
end
